import 'package:flutter/material.dart';

import 'color_constants.dart';

Widget customcontainer(Widget widget) {
  return Container(
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
          child: widget),
    ),
  );
}

Widget loadingwidget() {
  return CircularProgressIndicator(
    color: a1,
    backgroundColor: a2,
  );
}
