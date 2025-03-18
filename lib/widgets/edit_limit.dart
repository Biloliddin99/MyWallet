import 'package:flutter/material.dart';
import 'package:my_wallet/widgets/adaptive_button.dart';

class EditLimit extends StatefulWidget {
  final Function changeLimitAmount;
  final double limit;

  const EditLimit(
      {super.key, required this.changeLimitAmount, required this.limit});

  @override
  State<EditLimit> createState() => _EditLimitState();
}

class _EditLimitState extends State<EditLimit> {
  late TextEditingController _editController;

  @override
  void initState() {
    _editController = TextEditingController();
    _editController.text = widget.limit.toStringAsFixed(0);
    super.initState();
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: _editController,
            decoration: const InputDecoration(labelText: "Oylik limitingiz"),
            keyboardType: TextInputType.number,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdaptiveButton(
                  label: "Bekor qilish",
                  handler: () {
                    Navigator.of(context).pop();
                  },
                ),
                AdaptiveButton(
                  label: "O'zgartirish",
                  handler: () {
                    if (_editController.text.isEmpty) {
                      return;
                    }
                    final amount = double.parse(_editController.text);
                    if (amount > 0) {
                      widget.changeLimitAmount(amount);
                    }
                    Navigator.of(context).pop();
                  },
                  isFilled: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
