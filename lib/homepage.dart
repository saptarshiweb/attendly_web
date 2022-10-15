import 'package:attendly_web/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
              Expanded(flex: 3, child: leftwidget()),
              Expanded(flex: 1, child: rightwidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftwidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: left1()),
          const SizedBox(width: 20),
          Expanded(flex: 4, child: left2()),
        ],
      ),
    );
  }

  Widget rightwidget() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: t2),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(width: 2, color: t2),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(-5, 2),
                        blurRadius: 2,
                        spreadRadius: 3)
                  ], color: t2, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrettyQr(
                      typeNumber: 3,
                      size: 200,
                      data: 'helloworld',
                      roundEdges: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Icon ic(IconData icon) {
  return Icon(
    icon,
    color: col,
    size: 24,
  );
}

Widget techstackbar() {
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(width: 3, color: t2),
          borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: t2,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 3),
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(-2, 2),
                  blurRadius: 2,
                  spreadRadius: 3)
            ],
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ic(FontAwesome.android),
                ic(FontAwesome5.html5),
                ic(FontAwesome5.css3),
                ic(FontAwesome5.node_js),
                FlutterLogo(
                  size: 24,
                  textColor: col,
                ),
                ic(FontAwesome5.node),
                ic(FontAwesome5.python),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget left1() {
  return Container(
    child: Column(
      children: [
        Lottie.asset('gdsclogo.json'),
        const SizedBox(height: 30),
        Expanded(child: techstackbar()),
      ],
    ),
  );
}

Widget left2() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GradientText(
              'Welcome to Attendly! ',
              colors: [col, Colors.deepPurpleAccent.shade700],
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            Icon(
              FontAwesome5.autoprefixer,
              size: 28,
              color: col,
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: const Image(
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/gdsc_white.png',
              )),
        )
      ],
    ),
  );
}
