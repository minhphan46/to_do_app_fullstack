import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class TaskEntity extends Equatable {
  final String? id;
  String? title;
  final DateTime? date;
  bool? done;
  final Color? color;

  TaskEntity({
    this.id,
    this.title,
    this.done,
    this.date,
    this.color,
  });

  @override
  List<Object?> get props => [id, title, done, date];
}
