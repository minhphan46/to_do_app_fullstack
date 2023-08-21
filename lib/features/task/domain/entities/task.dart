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
