class Attendee {
  final String name;
  final String email;
  final String event;
  final String time;

  Attendee({
    required this.name,
    required this.email,
    required this.event,
    required this.time,
  });
}

class Event {
  final String name;
  final String des;
  final String attendance;
  final String eventid;
  final String mode;
  final String date;
  final String start;
  final String end;
  final String venue;

  Event({
    required this.name,
    required this.des,
    required this.attendance,
    required this.eventid,
    required this.mode,
    required this.date,
    required this.start,
    required this.end,
    required this.venue,
  });
}
