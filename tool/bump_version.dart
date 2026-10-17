import 'dart:io';

// Keep the rest of pubspec.yaml byte-for-byte unchanged, including CRLF files.
String bumpVersion(String contents, String part) {
  if (!['patch', 'minor', 'major'].contains(part)) {
    throw const FormatException('PART must be patch, minor, or major.');
  }
  final versionLines = RegExp(r'^version:', multiLine: true);
  final version = RegExp(
    r'^(version:[ \t]*)(\d+)\.(\d+)\.(\d+)\+(\d+)([ \t]*(?:#[^\r\n]*)?)(\r?)$',
    multiLine: true,
  );
  final match = version.firstMatch(contents);
  if (versionLines.allMatches(contents).length != 1 || match == null) {
    throw const FormatException(
        'Expected one version: MAJOR.MINOR.PATCH+BUILD line in pubspec.yaml.');
  }
  var major = int.parse(match[2]!);
  var minor = int.parse(match[3]!);
  var patch = int.parse(match[4]!);
  final build = int.parse(match[5]!);
  if (build < 1 || build >= 2100000000) {
    throw const FormatException(
        'The next Android version code must be between 1 and 2100000000.');
  }
  switch (part) {
    case 'major':
      major++;
      minor = 0;
      patch = 0;
      break;
    case 'minor':
      minor++;
      patch = 0;
      break;
    case 'patch':
      patch++;
      break;
  }
  return contents.replaceRange(match.start, match.end,
      '${match[1]}$major.$minor.$patch+${build + 1}${match[6]}${match[7]}');
}

void main(List<String> args) {
  if (args.length != 2) {
    stderr.writeln(
        'Usage: dart tool/bump_version.dart patch|minor|major pubspec.yaml');
    exitCode = 64;
    return;
  }
  try {
    final file = File(args[1]);
    final updated = bumpVersion(file.readAsStringSync(), args[0]);
    file.writeAsStringSync(updated);
    stdout.writeln(RegExp(r'^version:[^\r\n]*', multiLine: true)
        .firstMatch(updated)!
        .group(0));
  } on FormatException catch (error) {
    stderr.writeln(error.message);
    exitCode = 1;
  } on FileSystemException catch (error) {
    stderr.writeln('Could not update pubspec.yaml: ${error.message}');
    exitCode = 1;
  }
}
