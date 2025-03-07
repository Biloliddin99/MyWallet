import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String title;
  final DateTime date;
  final double cost;
  final IconData icon;

  Expense({
    required this.id,
    required this.title,
    required this.date,
    required this.cost,
    this.icon = Icons.ac_unit,
  });
}

class Expenses {
  final List<Expense> _list = [
    Expense(id: "01", title: "Laptop", date: DateTime.now(), cost: 5000000),
    Expense(id: "02", title: "Book", date: DateTime.now(), cost: 50000),
    Expense(id: "03", title: "Mouse", date: DateTime.now(), cost: 110000),
    Expense(id: "04", title: "Phone", date: DateTime.now(), cost: 2400000),
    Expense(id: "05", title: "Tool", date: DateTime.now(), cost: 300000),
  ];

  List<Expense> get list {
    return _list;
  }

  void addExpense(String title, DateTime date, double cost, IconData icon) {
    _list.insert(
        0,
        Expense(
            id: "${_list.length + 1}",
            title: title,
            date: date,
            cost: cost,
            icon: icon));
  }

  double getTotalCost(DateTime date) {
    double total = 0;
    for (var item in list) {
      if (item.date.year == date.year && item.date.month == date.month) {
        total += item.cost;
      }
    }
    return total;
    // return _list.fold(0, (sum, item) => sum + item.cost);
  }

  List<Expense> byDate(DateTime date) {
    return _list
        .where(
          (item) =>
              item.date.year == date.year && item.date.month == date.month,
        )
        .toList();
  }
}
