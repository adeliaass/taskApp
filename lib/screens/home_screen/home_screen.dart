import 'package:flutter/material.dart';
import 'package:flutter_do/screens/add_edit_task_screen/screen_add_edit_task.dart';
import 'package:flutter_do/screens/home_screen/widgets/task_priority_builder.dart';
import 'package:flutter_do/screens/home_screen/widgets/tasks_builder.dart';
import 'package:flutter_do/screens/home_screen/widgets/user_details_column.dart';
import 'package:flutter_do/utils/enums.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  ScreenHome({super.key, required this.userName});

  //Current-User-Name
  String userName;

  //Notifier
  ValueNotifier<Priorities> buttonNotifier = ValueNotifier(Priorities.today);

  //keys
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Get-Hour-Function
  String getHour() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        top: false,

        //Base-Container
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color.fromARGB(255, 104, 207, 255)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),

          //Base-Column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //User-Details-Column
              Padding(
                padding: const EdgeInsets.only(top: 80.0, left: 30.0),
                child: UserDetailsColumn(
                    userName: userName, getHour: getHour, height: height),
              ),

              //Button Rows Builder (Task-Priorities)
              TaskPriorityBuilder(
                  buttonNotifier: buttonNotifier, width: width, height: height),

              //Tasks-Builder
              TasksBuilder(
                  buttonNotifier: buttonNotifier,
                  scaffoldKey: scaffoldKey,
                  height: height)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ScreenAddEditTask(
                    taskMode: TaskMode.addTask,
                    taskPriority: buttonNotifier.value,
                  )));
        },
        backgroundColor: Color.fromARGB(255, 138, 188, 211), // Change to a soft matching blue
        label: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 40, 144, 241),
        ),
      ),
    );
  }
}
