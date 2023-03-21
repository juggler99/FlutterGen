import 'package:flutter/material.dart';

DropdownMenuItem<String> makeDropdownMenuItem(String strItem) {
  final item = DropdownMenuItem(
    child: Text(strItem),
    value: strItem,
  );
  return item;
}
