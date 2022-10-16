import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/bottom_bar_view.dart';

import '../../utils/size_config.dart';

import '../add_task/add_task_screen.dart';
import '../profile/profile_task.dart';
import '../task_list/task_list_screen.dart';
import '../assign_screen/assign_task_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController animationController;
  bool closeHeader = false;
  Widget tabBody = Container(
    color: const Color(0xfffcfcff),
  );
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = TaskListScreen(
      animationController: animationController,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            tabBody,
            bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          addClick: () {},
          changeIndex: (index) {
            print('current index is $index');
            if (index == 0) {
              tabBody = TaskListScreen(
                animationController: animationController,
              );
            }
            if (index == 1) {
              tabBody = AddTask(
                animationController: animationController,
                isEditMode: false,
              );
            }
            if (index == 2) {
              tabBody = AssignTaskScreen(
                animationController: animationController,
              );
            }
            if (index == 3) {
              tabBody = ProfileScreen(
                animationController: animationController,
              );
            }

            animationController.reverse().then((data) {
              if (!mounted) return;
              setState(() {});
            });
          },
        ),
      ],
    );
  }
}
