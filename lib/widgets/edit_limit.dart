import 'package:flutter/material.dart';

class EditLimit extends StatefulWidget {
  final Function changeLimitAmount;

  const EditLimit({super.key, required this.changeLimitAmount});

  @override
  State<EditLimit> createState() => _EditLimitState();
}

class _EditLimitState extends State<EditLimit> {
  late TextEditingController _editController;

  @override
  void initState() {
    _editController = TextEditingController();
    _editController.text = widget.changeLimitAmount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: _editController,
            decoration: InputDecoration(labelText: "Oylik limitingiz"),
            keyboardType: TextInputType.number,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Bekor qilish",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                ),
                onPressed: () {
                  if (_editController.text.isEmpty) {
                    return;
                  }
                  final amount = double.parse(_editController.text);
                  if (amount > 0) {
                    widget.changeLimitAmount(amount);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  "O'zgartirish",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
