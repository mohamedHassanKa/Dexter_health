import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dexter_health_ass/core/providers/task_provider.dart';
import 'package:dexter_health_ass/core/services/task_service.dart/task_service.dart';
import './ui/screens/login_screen/login.dart';
import 'package:flutter/services.dart';
import './ui/shared/theme.dart';
import 'package:sizer/sizer.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
      child: const MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  const MaterialAppWithTheme({super.key});

  @override
  State<MaterialAppWithTheme> createState() => _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends State<MaterialAppWithTheme> {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskProvider(TaskService()),
        )
      ],
      child: Sizer(
        builder: (context, _, deviceType) => MaterialApp(
          theme: themeChanger.getTheme(),
          title: 'Dexter health assig',
          home: LoginPage(),
        ),
      ),
    );
  }
}
