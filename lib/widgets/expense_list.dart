import 'package:flutter/material.dart';
import 'package:my_wallet/models/expense.dart';
import 'package:my_wallet/widgets/expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expense;
  final DateTime pickedDate;
  final Function deleteExpense;

  const ExpenseList({
    super.key,
    required this.expense,
    required this.pickedDate,
    required this.deleteExpense,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        clipBehavior: Clip.hardEdge,
        height: constraints.maxHeight,
        margin: EdgeInsets.only(top: 110),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: expense.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 5,
                ),
                itemBuilder: (context, index) {
                  return ExpenseItem(
                    expense[index].id,
                    expense[index].title,
                    pickedDate,
                    expense[index].cost,
                    expense[index].icon,
                    ValueKey(expense[index].id),
                    deleteExpense,
                  );
                },
                itemCount: expense.length,
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Text(
                      "Xarajatlar yo'q",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "asset/images/ufo.png",
                      fit: BoxFit.cover,
                      width: 250,
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
