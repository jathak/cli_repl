import 'dart:io';

import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

main() {
  test('example repl works with piped input', () async {
    var process =
        await TestProcess.start(Platform.executable, ['example/example.dart']);
    process.stdin.writeln('4;');
    process.stdin.writeln('a b c');
    process.stdin.writeln('d e f;');
    process.stdin.writeln('');
    process.stdin.writeln('test;');
    process.stdin.close();
    expect(
        process.stdout,
        emitsInOrder([
          '>>> 4;',
          '4;',
          '>>> a b c',
          '... d e f;',
          'a b c',
          'd e f;',
          '>>> ',
          '>>> test;',
          'test;'
        ]));
    expect(process.stdout, emitsDone);
    await process.shouldExit(0);
  });
}
