import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/util/color.dart';

class TodoCard extends StatelessWidget {
  final Todo data;
  final Function(int id) onRemove;
  final Function(int id) onMarkDone;

  const TodoCard({super.key, required this.data, required this.onRemove, required this.onMarkDone});

  bool get _isOverdue {
    final dueDate = DateFormat("dd MMMM yyyy HH:mm a").parse(data.date);
    return DateTime.now().isAfter(dueDate);
  }

  String get todoStatus => data.isDone ? "Done": _isOverdue ? "Overdue" : "Open";
  Color? get todoStatusColor => data.isDone ? null : _isOverdue ? null : secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: data.isDone ? doneColor : _isOverdue ? overdueColor : openColor,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text(
                  todoStatus,
                  style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w700)
                ),
              ),
              IconButton(
                onPressed: () => onRemove(data.id),
                icon: Icon(Icons.delete_outline_rounded)
              )
            ]
          ),
          Text(
            data.title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Due date:\n${data.date}"),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: tertiaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () => onMarkDone(data.id),
                child: Text("Done")
              )
            ]
          )
        ]
      )
    );
  }
}