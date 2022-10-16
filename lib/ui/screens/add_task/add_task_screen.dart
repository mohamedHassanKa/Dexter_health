import 'package:dexter_health_ass/core/models/task_model.dart';
import 'package:dexter_health_ass/core/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/naviguation_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../../shared/text_field.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:intl/intl.dart';
import '../../shared/option_button.dart';

class AddTask extends StatefulWidget {
  final AnimationController? animationController;
  TaskModel? taskModel;
  bool isEditMode;

  AddTask(
      {super.key,
      this.animationController,
      this.taskModel,
      this.isEditMode = false});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titlecontroller;
  late TextEditingController _notecontroller;
  late DateTime currentdate;
  static var _starthour = TimeOfDay.now();

  var endhour = TimeOfDay.now();

  late String _selectedReminder;

  @override
  void initState() {
    super.initState();
    _titlecontroller = TextEditingController(
        text: widget.isEditMode ? widget.taskModel!.title : '');
    _notecontroller = TextEditingController(
        text: widget.isEditMode ? widget.taskModel!.note : '');

    currentdate = widget.isEditMode
        ? DateTime.parse(widget.taskModel!.date)
        : DateTime.now();
    endhour = TimeOfDay(
      hour: _starthour.hour + 1,
      minute: _starthour.minute,
    );

    _selectedReminder = widget.isEditMode
        ? widget.taskModel!.assignedTo
        : 'QJ698xhBpZbDZskSaLlX';

    super.initState();
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _notecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    widget.animationController!.forward();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: NaviguationAnimationBuild(
              countWidget: 1,
              animationValue: 0,
              animationController: widget.animationController!,
              child: _buildform(context),
            ),
          ),
        ),
      ),
    );
  }

  Form _buildform(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          NaviguationAnimationBuild(
            countWidget: 1,
            animationValue: 0,
            animationController: widget.animationController!,
            child: _buildAppBar(context),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            'Title',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          MyTextfield(
            hint: 'Enter Title',
            icon: Icons.title,
            showicon: false,
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Title" : null;
            },
            textEditingController: _titlecontroller,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Note',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          MyTextfield(
            hint: 'Enter Note',
            icon: Icons.ac_unit,
            showicon: false,
            maxlenght: 40,
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Note" : null;
            },
            textEditingController: _notecontroller,
          ),
          Text(
            'Date',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          MyTextfield(
            hint: DateFormat('dd/MM/yyyy').format(currentdate),
            icon: Icons.calendar_today,
            readonly: true,
            showicon: false,
            validator: (value) {},
            ontap: () {
              _showdatepicker();
            },
            textEditingController: TextEditingController(),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Time',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    MyTextfield(
                      hint: DateFormat('HH:mm a').format(DateTime(
                          0, 0, 0, _starthour.hour, _starthour.minute)),
                      icon: Icons.watch_outlined,
                      showicon: false,
                      readonly: true,
                      validator: (value) {},
                      ontap: () {
                        Navigator.push(
                            context,
                            showPicker(
                              value: _starthour,
                              is24HrFormat: true,
                              accentColor: Colors.deepPurple,
                              onChange: (TimeOfDay newvalue) {
                                setState(() {
                                  _starthour = newvalue;
                                  endhour = TimeOfDay(
                                    hour: _starthour.hour < 22
                                        ? _starthour.hour + 1
                                        : _starthour.hour,
                                    minute: _starthour.minute,
                                  );
                                });
                              },
                            ));
                      },
                      textEditingController: TextEditingController(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'End Time',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    MyTextfield(
                      hint: DateFormat('HH:mm a').format(
                          DateTime(0, 0, 0, endhour.hour, endhour.minute)),
                      icon: Icons.watch,
                      showicon: false,
                      readonly: true,
                      validator: (value) {},
                      ontap: () {
                        Navigator.push(
                            context,
                            showPicker(
                              value: endhour,
                              is24HrFormat: true,
                              minHour: _starthour.hour.toDouble() - 1,
                              accentColor: Colors.deepPurple,
                              onChange: (TimeOfDay newvalue) {
                                setState(() {
                                  endhour = newvalue;
                                });
                              },
                            ));
                      },
                      textEditingController: TextEditingController(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Assign To: ',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          _buildDropdownButton(context),
          SizedBox(
            height: 3.h,
          ),
          Consumer<TaskProvider>(
            builder: ((context, taskProvider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MyButton(
                      color:
                          false ? Colors.green : Theme.of(context).primaryColor,
                      width: 40.w,
                      title: widget.isEditMode ? "Update Task" : 'Create Task',
                      func: () {
                        _addtask(taskProvider);
                      },
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  _addtask(TaskProvider taskProvider) async {
    if (_formKey.currentState!.validate()) {
      if (widget.isEditMode) {
        await taskProvider.updateTask(
          title: _titlecontroller.text,
          note: _notecontroller.text,
          date: DateFormat('yyyy-MM-dd').format(currentdate),
          starttime: _starthour.format(context),
          endtime: endhour.format(context),
          assignedTo: _selectedReminder.toString(),
          status: 'undone',
          id: widget.taskModel!.id,
        );
        Navigator.pop(context);
      } else {
        await taskProvider.AddTask(
          title: _titlecontroller.text,
          note: _notecontroller.text,
          date: DateFormat('yyyy-MM-dd').format(currentdate),
          starttime: _starthour.format(context),
          endtime: endhour.format(context),
          assignedTo: _selectedReminder.toString(),
          status: 'undone',
          id: '',
        );
      }
    }
  }

  Row _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.isEditMode ? 'Update Task' : 'Add Task',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox()
      ],
    );
  }

  _showdatepicker() async {
    var selecteddate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
      currentDate: DateTime.now(),
    );
    setState(() {
      selecteddate != null ? currentdate = selecteddate : null;
    });
  }

  DropdownButtonFormField<String> _buildDropdownButton(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(
        value: "QJ698xhBpZbDZskSaLlX",
        child: Text(
          "Nurse1",
        ),
      ),
      DropdownMenuItem(
        value: "ifNyD9gojJQJeZnvwPcu",
        child: Text(
          "Nurse2",
        ),
      ),
      DropdownMenuItem(
        value: "kZ86OxEfdMgzNsN75iMb",
        child: Text(
          "Nurse3",
        ),
      ),
    ];
    return DropdownButtonFormField(
      value: _selectedReminder,
      items: menuItems,
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(fontSize: 9.sp, color: Theme.of(context).primaryColor),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.deepPurple,
        size: 25.sp,
      ),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 0,
            )),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      ),
      onChanged: (val) {
        setState(() {
          _selectedReminder = val!;
        });
      },
    );
  }
}
