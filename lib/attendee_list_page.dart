import 'package:attendly_web/attendee_model.dart';
import 'package:attendly_web/color_constants.dart';
import 'package:attendly_web/custom_widget.dart';
import 'package:attendly_web/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendeeList extends StatefulWidget {
  const AttendeeList({super.key});

  @override
  State<AttendeeList> createState() => _AttendeeListState();
}

class _AttendeeListState extends State<AttendeeList> {
  TextEditingController eventname = TextEditingController();
  TextEditingController eventtime = TextEditingController();
  TextEditingController eventdate = TextEditingController();
  TextEditingController eventvenue = TextEditingController();
  TextEditingController eventdescription = TextEditingController();
  TextEditingController eventattendance = TextEditingController();
  TextEditingController eventstart = TextEditingController();
  TextEditingController eventend = TextEditingController();
  TextEditingController eventID = TextEditingController();

  // ignore: non_constant_identifier_names
  int total_attendee = 0;
  // ignore: non_constant_identifier_names
  bool new_event = false;

  String global_event_id = '';
  double eventBox = 300;

  clearTextInput() {
    eventname.clear();
    eventtime.clear();
    eventdate.clear();
    eventvenue.clear();
    eventdescription.clear();
    eventattendance.clear();
    eventstart.clear();
    eventend.clear();
    eventID.clear();
  }

  resetEvent() async {
    setState(() {
      eventBox = 0;
    });
    changeEvent();
  }

  changeEvent() async {
    setState(() {
      eventBox = 300;
    });
  }

  //Add an event
  Future addevent() async {
    String url = "https://attendly-backend.vercel.app/api/event/add";
    // ignore: unused_local_variable
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': eventname.text,
        'des': eventdescription.text,
        'attendance': '0',
        'eventid': eventID.text,
        'mode': 'Offline',
        'date': eventdate.text,
        'start': eventstart.text,
        'end': eventend.text,
        'venue': eventvenue.text,
      }),
    );

    clearTextInput();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade200,
          title: Row(
            children: [
              Text(
                'Create Event',
                style: TextStyle(
                    color: a2, fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel_rounded,
                      color: Colors.redAccent.shade700, size: 24))
            ],
          ),
          content: SizedBox(
              height: 150,
              width: 200,
              child: SingleChildScrollView(child: neweventbox())),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                addevent();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.redAccent.shade700),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //get Attendee List
  Future<List<Attendee>> getRequest() async {
    //replace your restFull API here.
    List<Attendee> alist = [];
    alist.clear();
    String url =
        "https://attendly-backend.vercel.app/api/attendee/list/$global_event_id";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;

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
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
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
                      onPressed: () async {
                        setState(() {
                          global_event_id = '1234'; resetEvent();
                          _showMyDialog();
                         
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: a2),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            Text(
                              'New Event   ',
                              style: TextStyle(
                                  color: t2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: headingwidget(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: eventBox,
                child: FutureBuilder(
                  future: getRequest(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(child: loadingwidget()),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget neweventbox() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 8),
        child: Column(
          children: [
            const SizedBox(height: 5),
            TextFormField(
              controller: eventname,
              maxLines: 1,
              decoration: InputDecoration(
                enabled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: a2, width: 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                labelText: 'Event Name',
              ),
            ),
            TextFormField(
              controller: eventID,
              maxLines: 1,
              decoration: InputDecoration(
                enabled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: a2, width: 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                labelText: 'Event ID',
              ),
            ),
            TextFormField(
              controller: eventdescription,
              maxLines: 3,
              minLines: 2,
              decoration: InputDecoration(
                enabled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: a2, width: 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                labelText: 'Event Description',
              ),
            ),
            TextFormField(
              controller: eventdate,
              maxLines: 1,
              decoration: InputDecoration(
                enabled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: a2, width: 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                labelText: 'Event Date',
              ),
            ),
            TextFormField(
              controller: eventtime,
              maxLines: 1,
              decoration: InputDecoration(
                enabled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: a2, width: 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                labelText: 'Event Time',
              ),
            ),

            TextFormField(
              controller: eventvenue,
              maxLines: 1,
              decoration: InputDecoration(
                enabled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: a2, width: 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                labelText: 'Event Venue',
              ),
            ),
            TextFormField(
              controller: eventstart,
              maxLines: 1,
              decoration: InputDecoration(
                enabled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: a2, width: 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                labelText: 'Start At',
              ),
            ),
            TextFormField(
              controller: eventend,
              maxLines: 1,
              decoration: InputDecoration(
                enabled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: a2, width: 0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                labelText: 'End At',
              ),
            ),

            //startat
          ],
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
                'Seminar Hall, North Block',
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
