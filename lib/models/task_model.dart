import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String name;
  final String description;
  final int priority;
  final String deadlineDate;
  final String deadlineTime;
  bool isDone;
  final List<int> reminders;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.priority,
    required this.deadlineDate,
    required this.deadlineTime,
    required this.isDone,
    required this.reminders,
  });

  TaskModel copyWith({
    String? id,
    String? name,
    String? description,
    int? priority,
    String? deadlineDate,
    String? deadlineTime,
    bool? isDone,
    List<int>? reminders,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      deadlineTime: deadlineTime ?? this.deadlineTime,
      isDone: isDone ?? this.isDone,
      reminders: reminders ?? this.reminders,
    );
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      priority: (map['priority'] is num)
          ? (map['priority'] as num).toInt()
          : int.tryParse(map['priority']?.toString() ?? '0') ?? 0,
      deadlineDate: map['deadlineDate'] ?? '',
      deadlineTime: map['deadlineTime'] ?? '',
      isDone: map['isDone'] ?? false,
      reminders: map['reminders'] != null
          ? List<int>.from(map['reminders'].map((m) => m is int ? m : int.tryParse(m.toString()) ?? 0))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'priority': priority,
      'deadlineDate': deadlineDate,
      'deadlineTime': deadlineTime,
      'isDone': isDone,
      'reminders': reminders,
    };
  }
}

extension TaskDateTime on TaskModel {
  DateTime get deadlineDateTime {
    try {
      final dateStr = deadlineDate.split(' ').first;
      final date = DateTime.tryParse(dateStr) ?? DateTime.now();

      final normalizedTime = deadlineTime.split(':')
          .map((part) => part.padLeft(2, '0'))
          .join(':');

      final timeParts = normalizedTime.split(':');
      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = int.tryParse(timeParts[1]) ?? 0;

      return DateTime(date.year, date.month, date.day, hour, minute);
    } catch (e) {
      debugPrint('Error parsing deadline: $e');
      return DateTime.now().add(const Duration(days: 1));
    }
  }
}