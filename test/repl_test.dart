import 'dart:io';

import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

main() {
  group("VM", () => testWith(Platform.executable, 'example/example.dart'));
  group("Node.js", () => testWith('node', 'build/example/example.js'));
}

testWith(String executable, String script) {
  test('example repl works', () async {
    if (!await new File(script).exists()) {
      fail("$script does not exist");
    }
    var process = await TestProcess.start(executable, [script]);
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

  // This is a regression test to ensure that the reply code doesn't fall prey
  // to dart-lang/sdk#34775.
  test('example repl throws an error', () async {
    if (!await new File(script).exists()) {
      fail("$script does not exist");
    }

    var process = await TestProcess.start(executable, [script]);
    process.stdin.writeln('throw;');
    expect(process.stdout, emits(">>> throw;"));
    expect(process.stdout, emitsDone);

    expect(process.stderr, emitsThrough(contains("oh no!")));

    await process.shouldExit(greaterThan(0));
  });
}
