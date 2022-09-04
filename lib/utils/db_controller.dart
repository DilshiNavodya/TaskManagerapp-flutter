import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final CollectionReference _tasks =
    FirebaseFirestore.instance.collection('tasks');

class DBController {
  static Stream<QuerySnapshot> readItems() {
    return _tasks.snapshots();
  }

  static Future<void> addItem({
    required String task_name,
    required String description,
  }) async {
    Map<String, dynamic> data = <String, dynamic>{
      "task_name": task_name,
      "description": description,
    };
    await _tasks
        .add(data)
        .whenComplete(() => print("Task added"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String task_name,
    required String description,
    required String taskId,
  }) async {
    Map<String, dynamic> data = <String, dynamic>{
      "task_name": task_name,
      "description": description,
    };
    await _tasks
        .doc(taskId)
        .update(data)
        .whenComplete(() => print("Task Updated"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteItem({
    required String taskId,
  }) async {
    await _tasks
        .doc(taskId)
        .delete()
        .whenComplete(() => print("Task Removed"))
        .catchError((e) => print(e));
  }
}
