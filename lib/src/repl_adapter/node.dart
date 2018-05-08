import 'dart:async';

import 'package:async/async.dart';
import 'package:js/js.dart';

import '../../cli_repl.dart';

class ReplAdapter {
  Repl repl;

  ReplAdapter(this.repl);

  Iterable<String> run() sync* {
    throw new UnsupportedError('Synchronous REPLs not supported in Node');
  }

  ReadlineInterface rl;

  Stream<String> runAsync() async* {
    var output = (stdin.isTTY ?? false) ? stdout : null;
    rl = readline.createInterface(
        new ReadlineOptions(input: stdin, output: output, prompt: repl.prompt));
    String statement = "";
    String prompt = repl.prompt;
    var controller = new StreamController<String>();
    var queue = new StreamQueue<String>(controller.stream);
    rl.on('line', allowInterop(([value]) {
      controller.add(value);
    }));
    while (true) {
      if (stdin.isTTY ?? false) stdout.write(prompt);
      var line = await queue.next;
      if (!(stdin.isTTY ?? false)) print('$prompt$line');
      statement += line;
      if (repl.validator(statement)) {
        yield statement;
        statement = "";
        prompt = repl.prompt;
        rl.setPrompt(repl.prompt);
      } else {
        statement += '\n';
        prompt = repl.continuation;
        rl.setPrompt(repl.continuation);
      }
    }
  }

  exit() {
    rl?.close();
  }
}

@JS('require')
external ReadlineModule require(String name);

final readline = require('readline');

@JS('process.stdin')
external Stdin get stdin;

@JS()
class Stdin {
  external bool get isTTY;
}

@JS('process.stdout')
external Stdout get stdout;

@JS()
class Stdout {
  external bool get isTTY;
  external void write(String data);
}

@JS()
class ReadlineModule {
  external ReadlineInterface createInterface(ReadlineOptions options);
}

@JS()
@anonymous
class ReadlineOptions {
  external get input;
  external get output;
  external String get prompt;
  external factory ReadlineOptions({input, output, String prompt});
}

@JS()
class ReadlineInterface {
  external void on(String event, void callback([object]));
  external void question(String prompt, void callback([object]));
  external void close();
  external void pause();
  external void setPrompt(String prompt);
}
