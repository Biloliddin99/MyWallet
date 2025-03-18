import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const AdaptiveTextfield(
      {super.key,
      this.keyboardType,
      required this.label,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
            keyboardType: keyboardType ?? TextInputType.text,
          )
        : CupertinoTextField(
            controller: controller,
            placeholder: label,
            keyboardType: keyboardType ?? TextInputType.text,
            padding: const EdgeInsets.all(10),
          );
  }
}
