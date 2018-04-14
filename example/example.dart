/// Example REPL that looks for a semicolon to complete a statement and then
/// echoes all completed statements.

import 'package:cli_repl/cli_repl.dart';

main(args) {
  var v = (str) => str.trim().isEmpty || str.trim().endsWith(';');
  var repl = new Repl(prompt: '>>> ', continuation: '... ', validator: v);
  for (var x in repl.run()) {
    if (x.trim().isEmpty) continue;
    print(x);
  }
}
