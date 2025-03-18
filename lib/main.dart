import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import './widgets/show_cash.dart';
import './widgets/monthly_budget.dart';
import 'widgets/expense_list.dart';
import './widgets/open_item_sheet.dart';
import './models/expense.dart';

void main() {
  /*
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,  
    DeviceOrientation.portraitUp,
  ]);
*/
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
  bool _showExpenseList = false;

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

  void deleteExpense(String id) {
    setState(() {
      _expenses.delete(id);
    });
  }

  Widget _showPortraitItems(deviceHeight, deviceWidth) {
    return Column(
      children: [
        Container(
          width: deviceWidth,
          height: deviceHeight > 640 ? deviceHeight * 0.2 : deviceHeight * 0.3,
          child: ShowCash(
            previousDate: _previousDate,
            nextDate: _nextDate,
            expenses: _expenses,
            picked: _pickedDate,
            pickDate: _pickDate,
          ),
        ),
        Container(
          width: deviceWidth,
          height: deviceHeight > 640 ? deviceHeight * 0.8 : deviceHeight * 0.7,
          child: Stack(
            children: [
              MonthlyBudget(
                expenses: _expenses,
                picked: _pickedDate,
              ),
              ExpenseList(
                expense: _expenses.byDate(_pickedDate),
                pickedDate: _pickedDate,
                deleteExpense: deleteExpense,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showLandscapeItems(deviceHeight, deviceWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ro'yxatni ko'rsatish"),
            Switch.adaptive(
              value: _showExpenseList,
              onChanged: (value) {
                setState(() {
                  _showExpenseList = value;
                });
              },
            ),
          ],
        ),
        _showExpenseList
            ? Column(
                children: [
                  Container(
                    width: deviceWidth,
                    height: deviceHeight * 0.9,
                    child: Stack(
                      children: [
                        MonthlyBudget(
                          expenses: _expenses,
                          picked: _pickedDate,
                        ),
                        ExpenseList(
                          expense: _expenses.byDate(_pickedDate),
                          pickedDate: _pickedDate,
                          deleteExpense: deleteExpense,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(
                width: deviceWidth,
                height: deviceHeight * 0.9,
                child: ShowCash(
                  previousDate: _previousDate,
                  nextDate: _nextDate,
                  expenses: _expenses,
                  picked: _pickedDate,
                  pickDate: _pickDate,
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Colors.blue,
      actions: Platform.isIOS
          ? [
              IconButton(
                color: Colors.white,
                onPressed: () {
                  _showAddItemSheet(context);
                },
                icon: const Icon(Icons.add),
              )
            ]
          : [],
      title: const Text(
        "My Wallet",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      ),
    );
    final topPadding = MediaQuery.of(context).padding.top;
    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        topPadding;
    final deviceWidth = MediaQuery.of(context).size.width;
    print(Platform.isAndroid);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLandscape
                ? _showLandscapeItems(deviceHeight, deviceWidth)
                : _showPortraitItems(deviceHeight, deviceWidth),
          ],
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () {
                _showAddItemSheet(context);
              },
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }
}
