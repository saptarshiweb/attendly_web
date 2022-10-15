import 'package:attendly_web/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accent,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: t2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(flex: 2, child: leftwidget()),
              Expanded(flex: 1, child: rightwidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftwidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Icon(
            FontAwesome5.autoprefixer,
            size: 50,
            color: col,
          )
        ],
      ),
    );
  }

  Widget rightwidget() {
    return Column(
      children: const [],
    );
  }
}
