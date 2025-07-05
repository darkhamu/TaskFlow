class TaskModel{
  final String id;
  final String name;
  final String description;
  final int priority;
  final String deadlineDate;
  final String deadlineTime;
  final bool isDone;

  TaskModel({ required this.id, required this.name, required this.description, required this.priority, required this.deadlineDate, required this.deadlineTime, required this.isDone,});

  factory TaskModel.fromMap(String id, Map<String, dynamic> map){
    return TaskModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      priority: int.parse(map['priority'] ?? '0'),
      deadlineDate: map['deadlineDate'] ?? '',
      deadlineTime: map['deadlineTime'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }
}