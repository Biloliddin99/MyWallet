import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker_plus/flutter_iconpicker.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/widgets/adaptive_button.dart';
import 'adaptive_textfield.dart';

class OpenItemSheet extends StatefulWidget {
  final Function addPlan;
  const OpenItemSheet(this.addPlan, {super.key});

  @override
  State<OpenItemSheet> createState() => _OpenItemSheetState();
}

class _OpenItemSheetState extends State<OpenItemSheet> {
  final _nameController = TextEditingController();
  final _expenseController = TextEditingController();
  IconData? _selectedIcon;
  DateTime? _selectedDate;

  void chooseDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024, 1),
            lastDate: DateTime(2025, 12),
            initialDatePickerMode: DatePickerMode.day)
        .then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  void submit() {
    if (_nameController.text.isEmpty ||
        _expenseController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }

    // Matnni double ga o'tkazish
    double expense;
    try {
      expense = double.parse(_expenseController.text);
    } catch (e) {
      // Agar xato bo'lsa, natija qaytmaydi
      return;
    }
    if (expense <= 0) {
      return;
    }

    widget.addPlan(
      _nameController.text,
      _selectedDate,
      expense, // double tipida berildi
      _selectedIcon,
    );

    Navigator.of(context).pop(); // Modal oynani yopadi
  }

  void _showExpenseIconPicker(BuildContext context) {
    FlutterIconPicker.showIconPicker(context).then((icon) {
      if (icon == null) {
        return;
      }
      setState(() {
        _selectedIcon = icon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: AdaptiveTextfield(
                label: "Xarajat nomi",
                controller: _nameController,
              ),
            ),
            AdaptiveTextfield(
              label: "Xarajat miqdori",
              controller: _expenseController,
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedDate != null
                    ? DateFormat.yMMMd().format(_selectedDate!)
                    : "Xarajat kuni tanlanmadi"),
                TextButton(
                  onPressed: () {
                    chooseDate(context);
                  },
                  child: const Text("KUNNI TANLASH!"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectedIcon == null
                    ? const Text("Icon tanlanmagan")
                    : Row(
                        children: [
                          const Text("Tanlangan icon: "),
                          Icon(_selectedIcon, size: 30),
                        ],
                      ),
                TextButton(
                  onPressed: () => _showExpenseIconPicker(context),
                  child: const Text("ICON TANLASH!"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdaptiveButton(
                  label: "BEKOR QILISH",
                  handler: () {
                    Navigator.of(context).pop();
                  },
                  isFilled: false,
                ),
                AdaptiveButton(
                  label: "KIRITISH",
                  handler: submit,
                  isFilled: true,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
