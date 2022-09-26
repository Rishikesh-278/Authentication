import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference our box
  final _myBox = Hive.box("mybox");

  //run this method if this is first time opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise",false],
    ];
  }

  void loadData()
  {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase()
  {
    _myBox.put("TODOLIST", toDoList);
  }
}