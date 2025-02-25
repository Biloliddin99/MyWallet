import 'package:flutter/material.dart';

class MonthlyBudget extends StatelessWidget {
  const MonthlyBudget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      size: 17,
                      color: Colors.blue,
                    ),
                    label: Text(
                      "10,000,000 so'm",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Text("49.4%")
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 5,
              decoration: BoxDecoration(
                color: Color.fromRGBO(206, 214, 239, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                heightFactor: 2,
                widthFactor: 0.7,
                child: Container(
                  width: double.infinity,
                  height: 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.blue,
                        Colors.blue.shade200,
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue,
                        blurRadius: 10,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
