import 'dart:io';

import 'package:grinder/grinder.dart';
import "package:node_preamble/preamble.dart" as preamble;

main() => grind();

@DefaultTask('Builds example.js')
grind() {
  var dir = new Directory('build/example');
  if (dir.existsSync()) dir.deleteSync(recursive: true);
  dir.createSync(recursive: true);
  var out = new File('build/example/example.js');
  Dart2js.compile(new File('example/example.dart'), outFile: out);
  var text = out.readAsStringSync();
  print('Adding preamble...');
  out.writeAsStringSync(preamble.getPreamble() + text);
  print('Done.');
}
