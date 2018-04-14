library cli_repl;

import 'dart:async';

import 'src/repl_impl.dart';

class Repl {
  /// Text displayed when prompting the user for a new statement.
  String prompt;

  /// Text displayed at start of continued statement line.
  String continuation;

  /// Called when a newline is entered to determine whether the queue a
  /// completed statement or allow for a continuation.
  StatementValidator validator;

  /// If true, use sharedStdIn instead of the normal stdin when running
  /// asynchronously. Ignored for run()
  ///
  /// This means that something else could listen to stdin after runAsync
  /// exits, but it also means that you have to call sharedStdIn.terminate()
  /// manually. This defaults to false.
  bool useSharedStdIn;

  Repl(
      {this.prompt: '',
      String continuation,
      StatementValidator validator,
      this.maxHistory: 50,
      this.useSharedStdIn: false})
      : continuation = continuation ?? ' ' * prompt.length,
        validator = validator ?? alwaysValid {
    _adapter = new ReplAdapter(this);
  }

  ReplAdapter _adapter;

  /// Run the REPL, yielding complete statements synchronously.
  Iterable<String> run() => _adapter.run();

  /// Run the REPL, yielding complete statements asynchronously.
  ///
  /// Note that the REPL will continue if you await in an "await for" loop.
  Stream<String> runAsync() => _adapter.runAsync();

  /// Kills and cleans up the REPL.
  Future exit() => _adapter.exit();

  /// History is by line, not by statement.
  ///
  /// The first item in the list is the most recent history item.
  List<String> history = [];

  /// Maximum history that will be kept in the list.
  ///
  /// Defaults to 50.
  int maxHistory;
}

/// Returns true if [text] is a complete statement or false otherwise.
typedef bool StatementValidator(String text);

final StatementValidator alwaysValid = (text) => true;
