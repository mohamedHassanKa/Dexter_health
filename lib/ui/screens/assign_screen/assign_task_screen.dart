import 'package:flutter/material.dart';
import '../../shared/naviguation_animation_widget.dart';

class AssignTaskScreen extends StatefulWidget {
  final AnimationController? animationController;
  const AssignTaskScreen({super.key, this.animationController});

  @override
  State<AssignTaskScreen> createState() => _AssignTaskScreenState();
}

class _AssignTaskScreenState extends State<AssignTaskScreen> {
  @override
  Widget build(BuildContext context) {
    widget.animationController!.forward();
    return Scaffold(
      body: Center(
        child: NaviguationAnimationBuild(
          countWidget: 1,
          animationValue: 0,
          animationController: widget.animationController!,
          child: Text(
            "Under Construction",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
