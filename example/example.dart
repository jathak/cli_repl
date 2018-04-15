/// Example REPL that looks for a semicolon to complete a statement and then
/// echoes all completed statements.

import 'package:cli_repl/cli_repl.dart';

main(args) async {
  var v = (str) => str.trim().isEmpty || str.trim().endsWith(';');
  var repl = new Repl(prompt: '>>> ', continuation: '... ', validator: v);
  await for (var x in repl.runAsync()) {
    if (x.trim().isEmpty) continue;
    print(x);
  }
}
