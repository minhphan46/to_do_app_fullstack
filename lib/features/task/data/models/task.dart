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
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? DateTime.now().toString(),
      title: json['title'] ?? "",
      date: json['date'] ?? DateTime.now(),
      done: json['done'] ?? false,
      color: json['color'] ??
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
    );
  }
}
