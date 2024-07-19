import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do/database/models/task_model.dart';
import 'package:flutter_do/firebase/firestore/firestore_functions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableTaskCard extends StatelessWidget {
  const SlidableTaskCard({
    super.key,
    required this.currentTask,
    required this.scaffoldKey,
  });

  //keys
  final GlobalKey<ScaffoldState> scaffoldKey;

  //Task-Object
  final TaskModel currentTask;

  @override
  Widget build(BuildContext context) {
    //Slidable-Widget
    return Slidable(
      key: Key(currentTask.taskId),

      //Start-Action
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (ctx) {
            dynamic result;
            if (currentTask.taskStatus) {
              result = FireStoreFunctions.instance
                  .updateTaskStatus(taskId: currentTask.taskId, status: false);
            } else {
              result = FireStoreFunctions.instance
                  .updateTaskStatus(taskId: currentTask.taskId, status: true);
            }
            //Error-Snack-Bar
            if (result is FirebaseException ||
                result is FirebaseAuthException) {
              ScaffoldMessenger.of(scaffoldKey.currentContext!)
                  .showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        result.message!,
                        style: const TextStyle(fontSize: 18.0),
                      )));
            }
          },
          icon: Icons.check,
          label: (!currentTask.taskStatus) ? 'Completed' : 'Not Complete',
          foregroundColor: (!currentTask.taskStatus)
              ? Colors.green.shade900
              : Colors.red.shade300,
          backgroundColor: Colors.transparent,
        ),
      ]),

      //End-Action
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (ctx) async {
            final result = await FireStoreFunctions.instance
                .deleteTask(taskId: currentTask.taskId);
            if (result is bool) {
              //Task-Deleted
              ScaffoldMessenger.of(scaffoldKey.currentContext!)
                  .showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.transparent,
                      content: Center(
                        child: Text(
                          'Task Deleted',
                          style: TextStyle(fontSize: 18.0, color: Colors.red),
                        ),
                      )));
            } else {
              //Error-Snack-Bar
              ScaffoldMessenger.of(scaffoldKey.currentContext!)
                  .showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        result.code,
                        style: const TextStyle(fontSize: 18.0),
                      )));
            }
          },
          icon: Icons.delete,
          label: 'Delete',
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.red.shade600,
        )
      ]),

      //List-Tile-Card-Widget
      child: Card(
        color: Colors.transparent,
        elevation: 1,
        shadowColor: const Color.fromARGB(255, 228, 227, 227),
        child: ListTile(
          leading: (currentTask.taskStatus)
              ? CircleAvatar(
                  child: ClipRRect(
                    child: Image.asset('assets/images/tick-icon-image.png'),
                  ),
                )
              : null,
          title: Center(
            child: Text(
              currentTask.task,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500),
            ),
          ),
          subtitle: (currentTask.taskDescription!.isNotEmpty)
              ? Center(
                  child: Text(
                    currentTask.taskDescription ?? "",
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}