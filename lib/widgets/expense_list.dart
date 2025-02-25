import 'package:flutter/material.dart';
import 'package:my_wallet/models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expense;
  final DateTime pickedDate;

  const ExpenseList({
    super.key,
    required this.expense,
    required this.pickedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 520,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(expense[index].icon),
              title: Text(
                expense[index].title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(DateFormat.yMMMM().format(pickedDate)),
              trailing: Text(
                "${expense[index].cost}",
                style: TextStyle(fontSize: 15),
              ),
            );
          },
          itemCount: expense.length,
        ),
      ),
    );
  }
}
