import 'package:to_do_mobi/features/task/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TaskModel extends TaskEntity {
  const TaskModel({
    String? id,
    String? title,
    DateTime? date,
    bool? done,
    Color? color,
  }) : super(
          id: id,
          title: title,
          date: date,
          done: done,
          color: color,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'] ?? DateTime.now().toString(),
      title: json['title'] ?? "",
      done: json['done'] ?? false,
      date: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      color: json['color'] ??
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
    );
  }
}
