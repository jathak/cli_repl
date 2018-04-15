# cli_repl

A simple library for creating CLI REPLs in Dart.

## Features

Example Usage:

```dart
/// Echoes all entered lines
for (var line in new Repl().run()) {
  print(line);
} 
```

### Statement Validation

By passing a `validator` to the `Repl` constructor, you can tell the REPL
whether some entered text is a complete statement or not. The REPL calls this
whenever a newline is entered to determine whether to yield a complete statement
or continue it on a new line. The default validator returns true for all text.

### Custom Prompts

By default, the REPL gives no prompt to the user when asking for a statement.
You can change this by passing a `prompt` to the `Repl` constructor. By default,
statement continuations on a new line will start with whitespace equal to the
length of the `prompt`. You can override this by passing in `continuation`.

See [`example/example.dart`][example] for a demonstration of statement
validation and custom prompts.

[example]: https://github.com/jathak/cli_repl/tree/master/example/example.dart

### History

A history of entered lines is stored. History entries are modified when edited.

By default, a maximum of 50 entries are stored. You can change this by passing
`maxHistory` into the `Repl` constructor.

### Navigation

- `Left`/`Ctrl-B`: Move left one character
- `Right`/`Ctrl-F`: Move right one character
- `Home`/`Ctrl-A`: Move to start of line
- `End`/`Ctrl-E`: Move to end of line
- `Ctrl-L`: Clear the screen
- `Ctrl-D`: If there is text, delete the character under the cursor. If there is
no text, exit.
- `Ctrl-F`: Moves forward one character
- `Ctrl-B`: Moves backward one character
- `Ctrl-U`: Kill (cut) to start of line
- `Ctrl-K`: Kill (cut) to end of line
- `Ctrl-Y`: Yank (paste) previously killed text, inserting at cursor
- `Up`/`Down`: Navigate within history

### Testing REPLs

If running without a terminal, the input will be printed along with the prompts,
allowing you to test REPLs made with this library by comparing stdout to the
expected log input and output together.

See [test/repl_test.dart][repl_test] for an example of this.

[repl_test]: https://github.com/jathak/cli_repl/tree/master/test/repl_test.dart

### Running on Node

If you compile this to JS with Dart 2, you can run it on Node.

There are a couple of behavior differences:

- Node's built-in readline library is used, so the supported navigation and
history commands may vary from the Dart version.
- Likewise, line history is managed by Node, and you can't change the maximum
number of entries or edit history manually from Dart.
- Only `Repl.runAsync()` works. Calling `Repl.run()` will throw an error.
