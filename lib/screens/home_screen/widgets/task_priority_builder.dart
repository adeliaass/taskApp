import 'package:flutter/material.dart';
import 'package:flutter_do/utils/enums.dart';

class TaskPriorityBuilder extends StatelessWidget {
  const TaskPriorityBuilder({
    super.key,
    required this.buttonNotifier,
    required this.width,
    required this.height,
  });

  final ValueNotifier<Priorities> buttonNotifier;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: buttonNotifier,
        builder: (ctx, newValue, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Today-Button-Container
              Material(
                elevation: (newValue == Priorities.today) ? 5 : 0,
                borderRadius: (newValue == Priorities.today)
                    ? BorderRadius.circular(20)
                    : null,
                color: Colors.transparent,
                child: Container(
                  width: width * 0.25,
                  height: height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: (newValue == Priorities.today)
                        ? const Color.fromARGB(255, 28, 151, 132)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        buttonNotifier.value = Priorities.today;
                      },
                      child: const Text(
                        'Today',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),

              //Tomorrow-Button-Container
              Material(
                elevation: (newValue == Priorities.tomorow) ? 5 : 0,
                borderRadius: (newValue == Priorities.tomorow)
                    ? BorderRadius.circular(20)
                    : null,
                color: Colors.transparent,
                child: Container(
                  width: width * 0.3,
                  height: height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: (newValue == Priorities.tomorow)
                        ? const Color.fromARGB(255, 28, 151, 132)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        buttonNotifier.value = Priorities.tomorow;
                      },
                      child: const Text(
                        'Tomorrow',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),

              //Next-Week-Button-Container
              Material(
                elevation: (newValue == Priorities.nextweek) ? 5 : 0,
                borderRadius: (newValue == Priorities.nextweek)
                    ? BorderRadius.circular(20)
                    : null,
                color: Colors.transparent,
                child: Container(
                  width: width * 0.3,
                  height: height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: (newValue == Priorities.nextweek)
                        ? const Color.fromARGB(255, 28, 151, 132)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        buttonNotifier.value = Priorities.nextweek;
                      },
                      child: const Text(
                        'Next Week',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
