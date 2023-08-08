import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TaskEntity extends Equatable {
  final String? id;
  final String? title;
  final DateTime? date;
  final bool? done;
  final Color? color;

  const TaskEntity({
    this.id,
    this.title,
    this.done,
    this.date,
    this.color,
  });
  //  {
  //   id ??= DateTime.now().toString();
  //   // id == null ? id = DateTime now : id = id
  //   date ??= DateTime.now();
  //   color ??=
  //       Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  // }

  @override
  List<Object?> get props => [id, title, done, date];
}
