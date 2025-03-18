import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatefulWidget {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;
  @override
  // ignore: overridden_fields
  final Key key;
  final Function deleteExpense;

  const ExpenseItem(
    this.id,
    this.title,
    this.date,
    this.amount,
    this.icon,
    this.key,
    this.deleteExpense,
  ) : super(key: key);

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  @override
  Widget build(BuildContext context) {
    final formattedCost = NumberFormat('#,###').format(widget.amount);
    return Dismissible(
      key: widget.key,
      onDismissed: (direction) {
        widget.deleteExpense(widget.id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        leading: Icon(widget.icon),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(DateFormat.yMMMM().format(widget.date)),
        trailing: Text(
          "$formattedCost so'm",
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
