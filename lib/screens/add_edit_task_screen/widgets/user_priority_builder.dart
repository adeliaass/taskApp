import 'package:flutter/material.dart';
import 'package:flutter_do/utils/enums.dart';

class UserPriorityBuilder extends StatelessWidget {
  const UserPriorityBuilder({
    super.key,
    required this.priorityNotifier,
    required this.width,
    required this.height,
  });

  final ValueNotifier<Priorities> priorityNotifier;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: priorityNotifier,
        builder: (ctx, priority, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Today-Container
              Container(
                width: width * 0.20,
                height: height * 0.04,
                decoration: BoxDecoration(
                    color: (priority == Priorities.today)
                        ? const Color.fromARGB(255, 10, 215, 238)
                        : Colors.transparent,
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: GestureDetector(
                    onTap: () => priorityNotifier.value = Priorities.today,
                    child: const Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),

              //Tomorrow-Container
              Container(
                width: width * 0.25,
                height: height * 0.04,
                decoration: BoxDecoration(
                    color: (priority == Priorities.tomorow)
                        ? const Color.fromARGB(255, 10, 215, 238)
                        : Colors.transparent,
                    border: Border.all(
                        color: const Color.fromARGB(255, 128, 116, 6)),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: GestureDetector(
                    onTap: () => priorityNotifier.value = Priorities.tomorow,
                    child: const Text(
                      'Tomorrow',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),

              //NextWeek-Container
              Container(
                width: width * 0.28,
                height: height * 0.04,
                decoration: BoxDecoration(
                    color: (priority == Priorities.nextweek)
                        ? const Color.fromARGB(255, 10, 215, 238)
                        : Colors.transparent,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: GestureDetector(
                    onTap: () => priorityNotifier.value = Priorities.nextweek,
                    child: const Text(
                      'Next Week',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
