import 'package:flutter_test/flutter_test.dart';
import './../../lib/utils/string_utils.dart';

void main() {
  test('word at position start empty string', () {
    var result = getWordAtPosition("", 0);
    expect(result.item1, "");
    expect(result.item2, 0);
  });

  test('word at position start', () {
    var result = getWordAtPosition("this is a test", 0);
    expect(result.item1, "this");
    expect(result.item2, 0);
  });

  test('word at position end', () {
    var result = getWordAtPosition("this is a test", 10);
    expect(result.item1, "test");
    expect(result.item2, 10);
  });

  test('word at position middle at new line', () {
    var result = getWordAtPosition("this is a\n test", 10);
    expect(result.item1, "a");
    expect(result.item2, 9);
  });

  test('word at position middle at colon', () {
    var result = getWordAtPosition("this is a:\n test", 10);
    expect(result.item1, "a");
    expect(result.item2, 9);
  });

  test('word at position middle of word', () {
    var result = getWordAtPosition("this is a test", 11);
    expect(result.item1, "a");
    expect(result.item2, 10);
  });
}
