import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import './widgets/show_cash.dart';
import './widgets/monthly_budget.dart';
import 'widgets/expense_list.dart';
import './widgets/open_item_sheet.dart';
import './models/expense.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyWallet(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.alike().fontFamily),
      localizationsDelegates: const [MonthYearPickerLocalizations.delegate],
    );
  }
}

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  DateTime _pickedDate = DateTime.now();
  final Expenses _expenses = Expenses();

  void _pickDate(BuildContext context) {
    showMonthYearPicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          _pickedDate = date;
        });
      }
    });
  }

  void _previousDate() {
    if (_pickedDate.year == 2024 && _pickedDate.month == 1) {
      return;
    }
    setState(() {
      _pickedDate = DateTime(_pickedDate.year, _pickedDate.month - 1);
    });
  }

  void _nextDate() {
    if (_pickedDate.year == DateTime.now().year &&
        _pickedDate.month == DateTime.now().month) {
      return;
    }
    setState(() {
      _pickedDate = DateTime(_pickedDate.year, _pickedDate.month + 1);
    });
  }

  void generalSumm() {}

  void _showAddItemSheet(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        shape: const BeveledRectangleBorder(),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Klaviaturaga moslashadi
            ),
            child: SingleChildScrollView(child: OpenItemSheet(_addPlan)),
          );
        });
  }

  void _addPlan(String title, DateTime date, double cost, IconData icon) {
    setState(() {
      _expenses.addExpense(title, date, cost, icon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              _showAddItemSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text(
          "My Wallet",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: [
          ShowCash(
            previousDate: _previousDate,
            nextDate: _nextDate,
            expenses: _expenses,
            picked: _pickedDate,
            pickDate: _pickDate,
          ),
          Stack(
            children: [
              MonthlyBudget(),
              ExpenseList(
                expense: _expenses.byDate(_pickedDate),
                pickedDate: _pickedDate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
