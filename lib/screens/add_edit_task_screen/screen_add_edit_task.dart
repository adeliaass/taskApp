import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do/database/models/task_model.dart';
import 'package:flutter_do/firebase/firestore/firestore_functions.dart';
import 'package:flutter_do/screens/add_edit_task_screen/widgets/task_text_form_field.dart';
import 'package:flutter_do/screens/add_edit_task_screen/widgets/user_priority_builder.dart';
import 'package:flutter_do/utils/enums.dart';

// ignore: must_be_immutable
class ScreenAddEditTask extends StatelessWidget {
  ScreenAddEditTask({
    super.key,
    required this.taskMode,
    this.task,
    this.description,
    this.taskId,
    required this.taskPriority,
  });

  //User-Task-Mode
  TaskMode taskMode;

  //Task-Priority
  Priorities taskPriority;

  //TextField-Focus-Nodes
  final _taskFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  //keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Controllers
  final taskController = TextEditingController();
  final descriptionController = TextEditingController();

  //Task Details -> (For-Edit-Task)
  String? task;
  String? description;
  late String? taskId;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    //Task-Priority-Notifier
    ValueNotifier<Priorities> priorityNotifier = ValueNotifier(taskPriority);

    (taskMode == TaskMode.editTask) ? taskController.text = task ?? "" : null;
    (taskMode == TaskMode.editTask)
        ? descriptionController.text = description ?? ""
        : null;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF80D8FF),
        elevation: 0,
        centerTitle: true,
        title: Text(
          (taskMode == TaskMode.addTask) ? 'Create Task' : 'Edit Task',
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          //Base-Container
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: width,
            height: height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFF80D8FF), Color(0xFF64FFDA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            )),

            //Base-Column
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Heading-Text
                  const Text(
                    "Schedule Task",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 27.0,
                        fontFamily: 'Rubik',
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),

                  //Task-Textfield-Form
                  TaskTextFormField(
                      formKey: formKey,
                      taskController: taskController,
                      taskFocusNode: _taskFocusNode,
                      height: height,
                      descriptionController: descriptionController,
                      descriptionFocusNode: _descriptionFocusNode),

                  //Priority-Text
                  const Text(
                    "Priority",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        fontFamily: 'Rubik',
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),

                  //Priroty-Container-Row
                  UserPriorityBuilder(
                      priorityNotifier: priorityNotifier,
                      width: width,
                      height: height),
                  SizedBox(
                    height: height * 0.06,
                  ),

                  //Add-Edit-Task-Button-Container
                  GestureDetector(
                    onTap: () async {
                      dynamic result;

                      //Delete-Edited-Task
                      if (taskMode == TaskMode.editTask &&
                          taskController.text.isEmpty &&
                          descriptionController.text.isEmpty) {
                        result = await FireStoreFunctions.instance
                            .deleteTask(taskId: taskId!);
                      } else if (formKey.currentState!.validate()) {
                        //Task-Priority
                        String taskPriority;
                        if (priorityNotifier.value == Priorities.today) {
                          taskPriority = "Today";
                        } else if (priorityNotifier.value ==
                            Priorities.tomorow) {
                          taskPriority = "Tomorrow";
                        } else {
                          taskPriority = "Next Week";
                        }

                        //Add-Task-Function
                        if (taskMode == TaskMode.addTask) {
                          final task = TaskModel(
                              taskId: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              task: taskController.text,
                              taskDescription: descriptionController.text,
                              taskPriority: taskPriority,
                              taskStatus: false);
                          result = await FireStoreFunctions.instance
                              .saveTask(task: task);
                        }
                        //Edit-Task-Function
                        else {
                          TaskModel task = TaskModel(
                              taskId: taskId!,
                              task: taskController.text,
                              taskDescription: descriptionController.text,
                              taskPriority: taskPriority,
                              taskStatus: false);
                          result = await FireStoreFunctions.instance
                              .updateTask(task: task);
                        }
                      }
                      //Validating-Results
                      if (result is bool) {
                        //Task-Added-Or-Updated-To-Database
                        Navigator.of(scaffoldKey.currentContext!).pop();
                      } else if (result is FirebaseAuthException) {
                        //Error-Fetching-Current-User
                        ScaffoldMessenger.of(scaffoldKey.currentContext!)
                            .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  result.message!,
                                  style: const TextStyle(fontSize: 18.0),
                                )));
                      } else {
                        //Error-Saving-Or-Updating-Task
                        ScaffoldMessenger.of(scaffoldKey.currentContext!)
                            .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  result.code,
                                  style: const TextStyle(fontSize: 18.0),
                                )));
                      }
                    },
                    child: Container(
                      width: width,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.black, Colors.black54],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topCenter),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                          child: Text(
                        (taskMode == TaskMode.addTask)
                            ? 'Add Task'
                            : 'Update Task',
                        style: const TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}