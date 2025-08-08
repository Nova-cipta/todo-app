import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/util/color.dart';

class AddTodoDialog extends StatefulWidget {
  final String name;

  const AddTodoDialog({super.key, required this.name});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final dateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: secondaryColor,
      alignment: Alignment.topCenter,
      insetPadding: EdgeInsets.symmetric(
        vertical: 0, horizontal: 10.w
      ),
      child: Container(
        width: 80.w,
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Text(
                "New Todo",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Title",
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)
                ),
              ),
              TextFormField(
                controller: titleCtrl,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Field must be filled!";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Insert todo's title here..",
                  border: InputBorder.none,
                  fillColor: surfaceColor,
                  filled: true
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Due date",
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)
                ),
              ),
              TextFormField(
                controller: dateCtrl,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final result = DateFormat("dd MMMM yyyy HH:mm a").tryParse(value);
                    if (result == null) {
                      return "Incorrect Date Format";
                    }
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "ex. 22 October 2025 11:12 AM",
                  border: InputBorder.none,
                  fillColor: surfaceColor,
                  filled: true
                )
              ),
              Align(
                alignment: Alignment.center,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: tertiaryColor,
                    minimumSize: Size(25.w, 40.px),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pop(
                        Todo(
                          id: 0,
                          title: titleCtrl.text,
                          assignedTo: widget.name,
                          isDone: false,
                          date: dateCtrl.text
                        )
                      );
                    }
                  },
                  child: Text("Save")
                )
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop,
                  child: Text("Cancel")
                )
              )
            ]
          )
        )
      )
    );
  }
}