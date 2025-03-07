import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/models/expense.dart';
import 'package:my_wallet/widgets/expense_list.dart';
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

  void changeLimitAmount(double amount) {
    setState(() {
      limit = amount;
    });
  }

  void changeLimitSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      shape: BeveledRectangleBorder(),
      builder: (context) {
        return EditLimit(
          changeLimitAmount: changeLimitAmount,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedLimit = NumberFormat("#,###").format(limit);
    final totalCost = widget.expenses.getTotalCost(widget.picked);
    final percent = 100 * totalCost / limit;
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 635,
      decoration: BoxDecoration(
        color: Color.fromRGBO(239, 240, 250, 1),
        borderRadius: const BorderRadius.only(
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
                    icon: Icon(
                      Icons.edit,
                      size: 17,
                      color: Colors.blue,
                    ),
                    label: Text(
                      "$formattedLimit so'm",
                      style: TextStyle(
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
  }
}
