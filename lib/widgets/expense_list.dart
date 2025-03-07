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
        clipBehavior: Clip.hardEdge,
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
          padding: const EdgeInsets.only(
            top: 10,
            right: 5,
          ),
          itemBuilder: (context, index) {
            final formattedCost =
                NumberFormat('#,###').format(expense[index].cost);
            return ListTile(
              leading: Icon(expense[index].icon),
              title: Text(
                expense[index].title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(DateFormat.yMMMM().format(pickedDate)),
              trailing: Text(
                "$formattedCost so'm",
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
