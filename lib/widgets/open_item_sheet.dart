import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OpenItemSheet extends StatefulWidget {
  final Function addPlan;
  const OpenItemSheet(this.addPlan);

  @override
  State<OpenItemSheet> createState() => _OpenItemSheetState();
}

class _OpenItemSheetState extends State<OpenItemSheet> {
  final _nameController = TextEditingController();
  final _expenseController = TextEditingController();
  IconData _selectedIcon = Icons.ac_unit;
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Xarajat nomi"),
            ),
            TextField(
              focusNode: FocusNode()..requestFocus(),
              keyboardType: TextInputType.number,
              controller: _expenseController,
              decoration: InputDecoration(labelText: "Xarajat miqdori"),
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
                  child: Text("KUNNI TANLASH!"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Icon tanlanmagan"),
                TextButton(
                  onPressed: () {},
                  child: Text("ICON TANLASH!"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("BEKOR QILISH"),
                ),
                ElevatedButton(
                  onPressed: () {
                    submit();
                  },
                  child: Text(
                    "KIRISH",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
