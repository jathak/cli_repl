# cli_repl

A simple library for creating CLI REPLs in Dart.

## Features

Example Usage:

```dart
/// Echoes all entered lines
await for (var line in new Repl().run()) {
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

See `example/example.dart` for a demonstration of statement validation and
custom prompts.

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
- `Ctrl-U`: Delete to start of line
- `Ctrl-K`: Delete to end of line
- `Up`/`Down`: Navigate within history
