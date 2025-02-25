import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import './widgets/pick_date.dart';
import './widgets/show_cash.dart';
import './widgets/monthly_budget.dart';
import './widgets/list_of_intake.dart';
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
  Expenses _expenses = Expenses();

  void _pickDate(BuildContext context) {
    showMonthYearPicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
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
    setState(() {
      _pickedDate = DateTime(_pickedDate.year, _pickedDate.month - 1);
    });
  }

  void _nextDate() {
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
        shape: BeveledRectangleBorder(),
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
          PickDate(
            pickDate: _pickDate,
            pickedDate: _pickedDate,
          ),
          ShowCash(
            previousDate: _previousDate,
            nextDate: _nextDate,
            expenses: _expenses,
            picked: _pickedDate,
          ),
          SizedBox(height: 40),
          Stack(
            children: [
              MonthlyBudget(),
              ListOfIntake(
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
