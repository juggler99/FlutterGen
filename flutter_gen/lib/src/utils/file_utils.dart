import 'package:flutter/material.dart';
import 'package:flutter_application_1/yase/yase.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter_treeview/flutter_treeview.dart';
import 'dart:developer';

Future<String> readAsync(String filename) async {
  return await File(filename).readAsString();
}

Future<File> writeAsync(String filename, String content) async {
  return await File(filename).writeAsString(content);
}

String read(String filename) {
  return File(filename).readAsStringSync();
}

void write(String filename, String content) {
  var file = File(filename);
  var parent = file.parent;
  if (!parent.existsSync()) {
    parent.createSync(recursive: true);
  }
  print("Write filename: $filename");
  File(filename).writeAsStringSync(content);
}

Future<bool> exists(String filename) async {
  var file = File(filename);
  return await file.exists();
}

Future<String> getDefaultRootFolderAsString({String appFolder = ""}) async {
  // only supporting iOs and Android
  var directory = await getApplicationDocumentsDirectory();
  if (Platform.isIOS) {
    directory = await getApplicationSupportDirectory();
  }
  if (appFolder.length > 0) {
    var newFFolder = directory.path + "/$appFolder";
    directory = Directory(newFFolder);
  }
  return directory.path;
}

String getYaseAppPath(BuildContext context, {appFolder: "YaSe"}) {
  var appRootFolder = YaSeApp.of(context)?.widget.YaSeAppPath;
  if (appRootFolder?.split(path.separator).last == appFolder) {
    return appRootFolder!;
  }
  return concatPaths([appRootFolder!, appFolder]);
}

String getFullPath(BuildContext context, String filename, String appFolder) {
  var folder = getYaseAppPath(context, appFolder: appFolder);
  if (!filename.contains(folder!)) return concatPaths([folder, filename]);
  return filename;
}

void createFile(
    BuildContext context, String filename, String appFolder, File? file,
    {bool saveIt = true}) {
  debugger();
  var fullFilename = getFullPath(context, filename, appFolder);
  file = File(fullFilename);
  if (saveIt) file.create();
}

String concatPaths(List<String> items) {
  return path.joinAll(items);
}

List<Node> getChildrenPathElements(Node parentNode, Directory dir) {
  var items = dir.listSync(recursive: true);
  List<Node> children = <Node>[];
  for (FileSystemEntity item in items) {
    List<String> parts = item.path.split('/');
    var node =
        Node(label: parts.last, key: parts.last, icon: Icons.description);
    if (item is Directory) {
      node = Node(
          label: parts.last,
          key: parts.last,
          icon: Icons.folder,
          data: item,
          expanded: true,
          children: getChildrenPathElements(node, item));
    }
    children.add(node);
  }
  return children;
}

List<Node> listFiles(BuildContext context, {String appFolder = "YaSe"}) {
  var strDir = getYaseAppPath(context, appFolder: appFolder);
  var dir = Directory(strDir);
  List<FileSystemEntity> files = dir.listSync(recursive: true);
  print("Dir: ${dir.path}");
  var rootNode = Node(
      label: "root", key: strDir, icon: Icons.folder, parent: true, data: dir);
  List<Node> nodes = getChildrenPathElements(rootNode, dir);
  rootNode = Node(
      label: "root",
      key: strDir,
      icon: Icons.folder,
      parent: true,
      data: dir,
      children: nodes,
      expanded: true);
  return [rootNode];
}
