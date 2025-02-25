import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickDate extends StatelessWidget {
  final Function pickDate;
  final DateTime pickedDate;
  const PickDate({
    super.key,
    required this.pickDate,
    required this.pickedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            pickDate(context);
          },
          child: Text(
            DateFormat.yMMMM().format(pickedDate),
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
