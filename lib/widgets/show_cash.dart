import 'package:flutter/material.dart';
import 'package:my_wallet/models/expense.dart';
import 'package:intl/intl.dart';

class ShowCash extends StatelessWidget {
  final Function() previousDate;
  final Function() nextDate;
  final Function pickDate;
  final Expenses expenses;
  final DateTime picked;
  const ShowCash(
      {super.key,
      required this.previousDate,
      required this.nextDate,
      required this.expenses,
      required this.picked,
      required this.pickDate});

  @override
  Widget build(BuildContext context) {
    double totalCost = expenses.getTotalCost(picked);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              pickDate(context);
            },
            child: Text(
              DateFormat.yMMMM().format(picked),
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    previousDate();
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalCost.toString(),
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "so'm",
                    style: TextStyle(
                      fontSize: 25,
                      height: 0.2,
                    ),
                  )
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    nextDate();
                  },
                  icon: Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
