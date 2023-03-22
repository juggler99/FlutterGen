import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import './dropdownlist.dart';
import './style_utils.dart';
import 'dart:developer';

typedef OnColorChangeCallback = void Function(Color, int, String, BuildContext);
typedef OnThemeChangeCallback = void Function(
    ThemeData, int, String, BuildContext);

class DropdownMenu<T> extends StatefulWidget {
  List<Tuple2<String, T>> menuItems = [];
  dynamic selectedValue;
  String selectedText = '';
  int selectedIndex = -1;
  double height = 20;
  double width = 100;
  _DropdownMenuState? state;

  DropdownMenu(
      menuItems, selectedValue, selectedText, selectedIndex, height, width) {
    debugger();
    this.menuItems = menuItems;
    this.selectedValue = selectedValue;
    this.selectedText = selectedText;
    this.selectedIndex = selectedIndex;
    this.height = height;
    this.width = width;
    createState();
  }

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState<T> extends State<DropdownMenu<T>> {
  @override
  void initState() {
    this.build(context);
    widget.state = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugger();
    print('width: $widget.width');
    print('height: $widget.height');
    return Container(
        width: widget.width,
        height: widget.height,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
                child: DropdownButton<T>(
              value: widget.selectedValue,
              items: getDropdownMenuItems<T>(context, widget.menuItems),
              onChanged: (value) {},
            ))));
  }
}

List<DropdownMenuItem<T>> getDropdownMenuItems<T>(
    BuildContext context, List<Tuple2<String, T>> menuItems) {
  debugger();
  List<DropdownMenuItem<T>> resultItems = [];
  for (var item in menuItems) {
    resultItems.add(getDropdownMenuItem(context, item.item1, item.item2));
  }
  print(resultItems);
  return resultItems;
}

DropdownMenuItem<T> getDropdownMenuItem<T>(
    BuildContext context, String label, dynamic value) {
  return DropdownMenuItem<T>(
    child: Text(label),
    value: value,
  );
}

DropdownMenu<T> getDropdownMenu<T>(
    BuildContext context,
    List<Tuple2<String, T>> menuItems,
    dynamic selectedValue,
    String selectedText,
    int selectedIndex,
    double height,
    double width) {
  DropdownMenu<T> w = DropdownMenu<T>(
      menuItems, selectedValue, selectedText, selectedIndex, height, width);
  debugger();
  return w;
}

CustomDropdown<ThemeData> getCustomDropdownMenuForThemeNames<T>(
    BuildContext context,
    ValueGetter<T> getterCallback,
    List<Tuple2<String, ThemeData>> Function(BuildContext) tupleCallback,
    String label,
    OnThemeChangeCallback callback,
    {double width = 150,
    double height = 20,
    State? tag = null}) {
  var _themeManager = getterCallback();
  return CustomDropdown<ThemeData>(
      child: Text(
        label,
        style: TextStyle(fontSize: 18),
      ),
      onChange: callback,
      dropdownButtonStyle: DropdownButtonStyle(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: width,
          height: height,
          elevation: 1,
          backgroundColor: Colors.white,
          primaryColor: Colors.black87),
      dropdownStyle: DropdownStyle(
        borderRadius: BorderRadius.circular(3),
        elevation: 3,
        padding: EdgeInsets.all(1),
      ),
      items: getDropdownItems(tupleCallback(context)));
}

CustomDropdown<Color> getCustomDropdownMenuForColor(String label,
    {double width = 150,
    double height = 20,
    OnColorChangeCallback? callback,
    State? tag = null}) {
  return CustomDropdown<Color>(
      child: Text(
        label,
        style: TextStyle(fontSize: 18),
      ),
      onChange: callback,
      dropdownButtonStyle: DropdownButtonStyle(
          padding: EdgeInsets.all(0),
          width: width,
          height: height,
          elevation: 1,
          backgroundColor: Colors.white,
          primaryColor: Colors.black87),
      dropdownStyle: DropdownStyle(
        borderRadius: BorderRadius.circular(3),
        elevation: 3,
        padding: EdgeInsets.all(1),
      ),
      items: getDropdownItems(getFullColorsAsListOfTuples()));
}
