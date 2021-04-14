# Changelog

## 0.2.2

- Avoid triggering https://github.com/dart-lang/sdk/issue/34775.

* Explicitly declare `Repl.exit()`'s type as `FutureOr<void>`.

## 0.2.1

- Migrate to null-safety
- Require \>=Dart 2.12

## 0.2.0+2

- Removed a `dart:async` import that isn't required for \>=Dart 2.1.
- Require \>=Dart 2.1.

## 0.2.0+1

- Support Dart 2 stable.

## 0.2.0

- Removes option to use sharedStdIn, as well as the `io` package dependency.

## 0.1.3

- Line editing should now work in environments like the Emacs terminal where
`EscO` is used for ANSI-escaped input instead of the more typical `Esc[`.

- Fixed issue with the prompt changing to the Node default when running on it.

- Broadened dependency on the async package to support 2.x.x versions.

## 0.1.2

- If compiled to JS and run with Node, `Repl.runAsync()` should now work. It
uses the [Node readline][] library for line editing.

- `Repl.runAsync()` now supports running with no terminal, and should operate
similarly to how `Repl.run()` does, both on the Dart VM and on Node.

[Node readline]: https://nodejs.org/api/readline.html

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
