import 'package:attendly_web/attendee_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendly Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'lato'),
      home: const AttendeeList(),
    );
  }
}
