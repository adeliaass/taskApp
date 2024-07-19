class TaskModel {
  String taskId;
  String task;
  String? taskDescription;
  String taskPriority;
  bool taskStatus;

  TaskModel(
      {required this.taskId,
      required this.task,
      this.taskDescription,
      required this.taskPriority,
      required this.taskStatus});

  Map<String, dynamic> toMap() {
    return {
      "Task Id": taskId,
      "Task": task,
      "Task Description": taskDescription,
      "Task Priority": taskPriority,
      "Task Status":taskStatus
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> taskMap) {
    return TaskModel(
        taskId: taskMap['Task Id'],
        task: taskMap["Task"],
        taskPriority: taskMap["Task Priority"],
        taskDescription: taskMap["Task Description"],
        taskStatus: taskMap["Task Status"]);
  }
}
