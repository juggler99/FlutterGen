import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart' show loadYaml;
import 'dart:developer';

Future<Map<String, dynamic>> loadYamlAsset(String path) async {
  final yamlString = await rootBundle.loadString(path);
  final yamlMap = loadYaml(yamlString);
  print("yamlMap.keys: ${yamlMap.keys}");
  var result = Map<String, dynamic>.from(yamlMap);
  print("result.keys: ${result.keys}");
  return result;
}
