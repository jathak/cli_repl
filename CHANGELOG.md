# Changelog

## 0.1.1

- Fix issues on Windows

## 0.1.0

- Makes `Repl.run()` synchronous, since that use case is probably more common.
The asynchronous version can now be run with `Repl.runAsync()`.

- When running with `Repl.run()` and no terminal, this will no longer crash, and
instead print both prompts and the input, allowing you to test a REPL by piping
input to it.

- Adds support for limited cutting and pasting with Ctrl-U, Ctrl-K, and Ctrl-Y.

## 0.0.1

- Initial release
