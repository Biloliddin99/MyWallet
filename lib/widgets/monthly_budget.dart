import 'package:flutter/material.dart';

class MonthlyBudget extends StatelessWidget {
  const MonthlyBudget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 635,
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Oylik budjeti:"),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        size: 17,
                        color: Colors.blue,
                      ),
                      label: Text(
                        "10,000,000 so'm",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Text("49.4%")
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
