import 'package:flutter/material.dart';

Widget getTabItem(String label, IconData iconData) {
  final labelWidth = (label.length * 10.0) + 20.0; // calculate label width
  return Tab(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //color: isSelected ? Colors.blue : Colors.white,
      ),
      child: SizedBox(
        height: 40,
        width: labelWidth,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                label,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(
                iconData,
                color: const Color(0xffef5145),
                size: 21,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
