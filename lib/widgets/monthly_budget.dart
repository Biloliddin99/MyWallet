import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/models/expense.dart';
import './progress.bar.dart';
import './edit_limit.dart';

class MonthlyBudget extends StatefulWidget {
  final Expenses expenses;
  final DateTime picked;

  const MonthlyBudget({
    super.key,
    required this.expenses,
    required this.picked,
  });

  @override
  State<MonthlyBudget> createState() => _MonthlyBudgetState();
}

class _MonthlyBudgetState extends State<MonthlyBudget> {
  double limit = 10000000;

  void changeLimitAmount(double amount, DateTime date) {
    setState(() {
      limit = amount;
    });
  }

  void changeLimitSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      shape: const BeveledRectangleBorder(),
      builder: (context) {
        return EditLimit(
          changeLimitAmount: changeLimitAmount,
          limit: limit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedLimit = NumberFormat("#,###").format(limit);
    final totalCost = widget.expenses.getTotalCost(widget.picked);
    final percent = 100 * totalCost / limit;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: constraints.maxHeight,
          margin: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(239, 240, 250, 1),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Oylik budjeti:"),
                      TextButton.icon(
                        onPressed: () => changeLimitSheet(context),
                        icon: const Icon(
                          Icons.edit,
                          size: 17,
                          color: Colors.blue,
                        ),
                        label: Text(
                          "$formattedLimit so'm",
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("${percent.toStringAsFixed(0)} %")
                ],
              ),
              ProgressBar(
                percent: percent,
              ),
            ],
          ),
        );
      },
    );
  }
}
