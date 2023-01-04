import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:on_my_mind/pages/home_page.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';

const bool dev_mode = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'OnMyMind';

  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: dev_mode ? const MyHomePage(title: _title) : const LoginPage(),
    );
  }
}
