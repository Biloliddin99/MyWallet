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
    final bool isLastDate = picked.year == DateTime.now().year &&
        picked.month == DateTime.now().month;
    final bool isFirstDate = picked.year == 2024 && picked.month == 1;
    double totalCost = expenses.getTotalCost(picked);
    final String cash = NumberFormat('#,###').format(totalCost);

    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 40),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              pickDate(context);
            },
            child: Text(
              DateFormat("MMMM, y").format(picked),
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.5,
                        color: isFirstDate ? Colors.grey : Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    previousDate();
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    size: 30,
                    color: isFirstDate ? Colors.grey : Colors.blue,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    cash,
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
                  ),
                  const Text(
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
                    border: Border.all(
                        width: 1.5,
                        color: isLastDate ? Colors.grey : Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    nextDate();
                  },
                  icon: Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: isLastDate ? Colors.grey : Colors.blue,
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
