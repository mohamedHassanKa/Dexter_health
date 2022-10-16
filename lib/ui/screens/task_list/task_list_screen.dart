import 'package:dexter_health_ass/core/providers/task_provider.dart';
import 'package:dexter_health_ass/ui/screens/add_task/add_task_screen.dart';
import 'package:dexter_health_ass/ui/screens/task_list/task_item.dart';
import 'package:flutter/material.dart';
import '../../shared/naviguation_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../core/models/task_model.dart';
import './task_list_screen.dart';

class TaskListScreen extends StatefulWidget {
  final AnimationController? animationController;
  const TaskListScreen({super.key, this.animationController});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    //Future.microtask(() => context.read<TaskProvider>().getTaskList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animation = widget.animationController!;
    return Scaffold(
      body: Center(
        child: Consumer<TaskProvider>(builder: (context, taskProvider, widget) {
          if (taskProvider.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            animation.forward();
            return StreamBuilder(
              stream: context.read<TaskProvider>().getTaskList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TaskModel>> snapshot) {
                if (snapshot.hasError) {
                  return const Text('An Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                }

                return snapshot.data!.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var task = snapshot.data![index];

                          return NaviguationAnimationBuild(
                            countWidget: snapshot.data?.length ?? 1,
                            animationValue: index,
                            animationController: animation,
                            child: TaskItem(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AddTask(
                                              animationController: animation,
                                              taskModel: snapshot.data![index],
                                              isEditMode: true,
                                            )));
                              },
                              task: task,
                              onCheckboxChanged: () {
                                context.read<TaskProvider>().updateTaskStatus(
                                    status: snapshot.data![index].status,
                                    docId: snapshot.data![index].id);
                              },
                            ),
                          );
                        },
                      )
                    : const Text('No data Available');
              },
            );
          }
        }),
      ),
    );
  }
}
