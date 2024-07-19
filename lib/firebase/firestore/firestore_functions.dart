import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_do/database/models/task_model.dart';
import 'package:flutter_do/utils/firestore_collections.dart';
import 'package:flutter_do/utils/enums.dart';

//Firebase-FireStore-Functions
class FireStoreFunctions {
  //Singleton-Object
  FireStoreFunctions._internal();
  static FireStoreFunctions instance = FireStoreFunctions._internal();
  factory FireStoreFunctions() => instance;

  //Save-Task-To-Firestore
  Future<dynamic> saveTask({required TaskModel task}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection(userCollections)
            .doc(currentUser.uid)
            .collection(taskCollections)
            .doc(task.taskId)
            .set(task.toMap());

        return true;
      } else {
        return FirebaseAuthException(
            code: "ERROR_FETCHING_USER", message: "Error fetching user!");
      }
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Fetch-Tasks-By-Priority
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchTaskByPriority(
      Priorities priority) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      if (priority == Priorities.today) {
        return FirebaseFirestore.instance
            .collection(userCollections)
            .doc(currentUser.uid)
            .collection(taskCollections)
            .where("Task Priority", isEqualTo: "Today")
            .snapshots();
      } else if (priority == Priorities.tomorow) {
        return FirebaseFirestore.instance
            .collection(userCollections)
            .doc(currentUser.uid)
            .collection(taskCollections)
            .where("Task Priority", isEqualTo: "Tomorrow")
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection(userCollections)
            .doc(currentUser.uid)
            .collection(taskCollections)
            .where("Task Priority", isEqualTo: "Next Week")
            .snapshots();
      }
    } else {
      return Stream.error(FirebaseAuthException(
          code: "ERROR_FETCHING_USER", message: "Error fetching user!"));
    }
  }

  //Update-Task-In-Firebase
  Future<dynamic> updateTask({required TaskModel task}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection(userCollections)
            .doc(currentUser.uid)
            .collection(taskCollections)
            .doc(task.taskId)
            .update({
          "Task": task.task,
          "Task Description": task.taskDescription,
          "Task Priority": task.taskPriority
        });
        return true;
      } else {
        return FirebaseAuthException(
            code: "ERROR_FETCHING_USER", message: "Error fetching user!");
      }
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Update-Task-Status
  Future<dynamic> updateTaskStatus(
      {required String taskId, required bool status}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection(userCollections)
            .doc(currentUser.uid)
            .collection(taskCollections)
            .doc(taskId)
            .update({"Task Status": status});
        return true;
      } else {
        return FirebaseAuthException(
            code: "Error Fetching User!", message: "Error fetching user!");
      }
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Delete-Task-On-Firebase
  Future<dynamic> deleteTask({required String taskId}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection(userCollections)
            .doc(currentUser.uid)
            .collection(taskCollections)
            .doc(taskId)
            .delete();
        return true;
      } else {
        return FirebaseAuthException(
            code: "Error Fetching User", message: "Error fetching user!");
      }
    } on FirebaseException catch (e) {
      return e;
    }
  }
}
