import 'package:attendly_web/attendee_model.dart';
import 'package:attendly_web/color_constants.dart';
import 'package:attendly_web/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendeeList extends StatefulWidget {
  const AttendeeList({super.key});

  @override
  State<AttendeeList> createState() => _AttendeeListState();
}

class _AttendeeListState extends State<AttendeeList> {
  // ignore: non_constant_identifier_names
  int total_attendee = 0;
  Future<List<Attendee>> getRequest() async {
    //replace your restFull API here.
    String url = "https://attendly-backend.vercel.app/api/attendee/list";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Attendee> alist = [];
    for (var singleUser in responseData) {
      Attendee attendee = Attendee(
          name: singleUser["name"],
          email: singleUser["email"],
          event: singleUser["event"],
          time: singleUser["time"]);

      //Adding user to the list.
      alist.add(attendee);
    }
    setState(() {
      total_attendee = alist.length;
    });
    return alist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.grey.shade400.withOpacity(0.4),
          Colors.grey.shade400.withOpacity(0.6),
          Colors.grey.shade400.withOpacity(0.5)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(FontAwesome5.phoenix_squadron, color: a2, size: 22),
                  const SizedBox(width: 15),
                  Text(
                    'Attendee List  ',
                    style: TextStyle(
                        color: a1, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_drop_down_circle_outlined,
                      color: a1, size: 33),
                  const SizedBox(width: 16),
                  Container(
                    height: 30.0,
                    width: 2.5,
                    color: a2,
                  ),
                  const SizedBox(width: 17),
                  Text(
                    'Total $total_attendee Attendees',
                    style: TextStyle(
                        color: a3, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        //navigate back to home page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: t2),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 14, bottom: 14),
                        child: Row(
                          children: [
                            Icon(Typicons.left_open_outline,
                                color: t1, size: 18),
                            const SizedBox(width: 14),
                            Text(
                              'Back',
                              style: TextStyle(
                                  color: t1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    FontAwesome5.list_ul,
                    color: a1,
                    size: 24,
                  ),
                  const SizedBox(width: 9),
                  Text(
                    '''See who's attending the event !!!''',
                    style: TextStyle(
                        color: a2, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: a2),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            Text(
                              'New Event     ',
                              style: TextStyle(
                                  color: t2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.new_label_outlined, color: t2, size: 18),
                          ],
                        ),
                      )),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: t2),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            Text(
                              'Event Actions     ',
                              style: TextStyle(
                                  color: t1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(FontAwesome.down_circled2,
                                color: t1, size: 18),
                          ],
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: headingwidget(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 350,
                child: FutureBuilder(
                  future: getRequest(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: a1,
                              backgroundColor: a2,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              child: listTile(
                                  snapshot.data[index].name,
                                  snapshot.data[index].email,
                                  snapshot.data[index].event,
                                  snapshot.data[index].time),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listTile(String name, String email, String event, String time) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: t2),
      child: Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        child: Row(
          children: [
            Expanded(
              flex: fval,
              child: Text(
                name,
                style: TextStyle(
                    color: t1, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: fval,
              child: Text(
                email,
                style: TextStyle(
                    color: t1, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: fval,
              child: Text(
                'GDSC-WELCOME',
                style: TextStyle(
                    color: t1, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: fval - 1,
              child: Text(
                'Offline',
                style: TextStyle(
                    color: t1, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: fval,
              child: Text(
                'Seminal Hall, North Block',
                style: TextStyle(
                    color: t1, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: fval - 1,
              child: Text(
                time,
                style: TextStyle(
                    color: t1, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: fval - 1,
              child: Text(
                '06:00 PM',
                style: TextStyle(
                    color: t1, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                flex: fval - 2,
                child: Icon(
                  FontAwesome5.share_alt,
                  color: t1,
                  size: 18,
                )),
          ],
        ),
      ),
    );
  }

  Widget headingwidget() {
    return Row(
      children: [
        Expanded(
          flex: fval,
          child: Text(
            'Attendee Name',
            style:
                TextStyle(color: a3, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: fval,
          child: Text(
            'Email',
            style:
                TextStyle(color: a3, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: fval,
          child: Text(
            'Code',
            style:
                TextStyle(color: a3, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: fval - 1,
          child: Text(
            'Event Type',
            style:
                TextStyle(color: a3, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: fval,
          child: Text(
            'Venue',
            style:
                TextStyle(color: a3, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: fval - 1,
          child: Text(
            'Start At',
            style:
                TextStyle(color: a3, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: fval - 1,
          child: Text(
            'End At',
            style:
                TextStyle(color: a3, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            flex: fval - 2,
            child: Icon(FontAwesome5.uikit, color: a2, size: 30)),
      ],
    );
  }

  Widget attendeeTile() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: t2),
      child: Row(),
    );
  }
}
