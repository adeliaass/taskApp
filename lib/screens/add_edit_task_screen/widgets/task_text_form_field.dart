import 'package:flutter/material.dart';

class TaskTextFormField extends StatelessWidget {
  const TaskTextFormField({
    super.key,
    required this.formKey,
    required this.taskController,
    required FocusNode taskFocusNode,
    required this.height,
    required this.descriptionController,
    required FocusNode descriptionFocusNode,
  })  : _taskFocusNode = taskFocusNode,
        _descriptionFocusNode = descriptionFocusNode;

  final GlobalKey<FormState> formKey;
  final TextEditingController taskController;
  final FocusNode _taskFocusNode;
  final double height;
  final TextEditingController descriptionController;
  final FocusNode _descriptionFocusNode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          //Task-TextField
          TextFormField(
            controller: taskController,
            focusNode: _taskFocusNode,
            maxLines: 1,
            validator: (task) =>
                (task == null || task.isEmpty) ? 'Task is Empty' : null,
            decoration: InputDecoration(
                hintText: 'Task',
                hintStyle: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.w700),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0))),
          ),
          SizedBox(
            height: height * 0.05,
          ),

          //Description-TextField
          TextFormField(
            controller: descriptionController,
            focusNode: _descriptionFocusNode,
            maxLength: 40,
            maxLines: 2,
            decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.w700),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.blueAccent, width: 2.0))),
          ),

          SizedBox(
            height: height * 0.02,
          ),
        ],
      ),
    );
  }
}