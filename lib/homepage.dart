import 'package:attendly_web/color_constants.dart';
import 'package:attendly_web/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
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

  Widget qrwidget() {
    return customcontainer(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrettyQr(
          typeNumber: 3,
          size: 200,
          data: 'helloworld',
          roundEdges: true,
        ),
      ),
    );
  }

  Widget rightwidget() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: t2),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            qrwidget(),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: customcontainer(Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'GDSC Info Session ',
                            style: TextStyle(
                                color: t1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            FontAwesome.rocket,
                            color: col,
                            size: 28,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Scan QR to register',
                  style: TextStyle(
                      color: t1, fontSize: 22, fontWeight: FontWeight.w900),
                ),
                Text(
                  'Attendance',
                  style: TextStyle(
                      color: t1, fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
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
  return Column(
    children: [
      SizedBox(
        height: 100,
        child: Lottie.network(
            'https://assets3.lottiefiles.com/private_files/lf30_um4sz3z5.json'),
      ),
      const SizedBox(height: 30),
      Expanded(child: techstackbar()),
    ],
  );
}

Widget credit() {
  return customcontainer(Padding(
    padding: const EdgeInsets.all(14.0),
    child: Row(
      children: [
        Text(
          'Made with ',
          style:
              TextStyle(color: t1, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          'Flutter ',
          style: TextStyle(
              color: Colors.blueAccent.shade400,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const FlutterLogo(
          size: 24,
        ),
        const SizedBox(width: 20),
        Text(
          '•',
          style:
              TextStyle(color: col, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 20),
        Icon(
          FontAwesome5.copyright,
          color: t1,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          'Copyright',
          style:
              TextStyle(color: col, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Text(
          '• Google Developer Student Clubs KGEC',
          style:
              TextStyle(color: t1, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ));
}

Widget left2() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GradientText(
              'Welcome to Attendly ',
              colors: [col, Colors.deepPurpleAccent.shade700],
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 80,
                child: Lottie.network(
                    'https://assets2.lottiefiles.com/packages/lf20_221k5lrw.json')),
            const SizedBox(width: 20),
            Expanded(
              child: customcontainer(Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Attendee ',
                      style: TextStyle(
                          color: t1, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Icon(Typicons.right_open, color: t1, size: 18)
                  ],
                ),
              )),
            ),
            const SizedBox(width: 20),
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
        ),
        const SizedBox(height: 20),
        credit()
      ],
    ),
  );
}
