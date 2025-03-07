import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double percent;
  const ProgressBar({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          widthFactor: percent / 100,
          child: Container(
            width: double.infinity,
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
                  spreadRadius: -3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
