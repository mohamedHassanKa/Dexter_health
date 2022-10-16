import 'package:dexter_health_ass/core/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final Function onCheckboxChanged;
  final GestureDragCancelCallback onTap;

  TaskItem(
      {required this.onCheckboxChanged,
      required this.onTap,
      required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Checkbox(
                    value: task.status == 'done' ? true : false,
                    onChanged: (val) {
                      onCheckboxChanged();
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      this.onTap();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            spreadRadius: .8,
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(task.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.black)),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      task.note,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      ' - ',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54),
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.black54,
                                      size: 10.0,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      task.date,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
