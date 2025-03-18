import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final Function handler;
  final bool isFilled;
  const AdaptiveButton({
    super.key,
    this.isFilled = false,
    required this.label,
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? isFilled
            ? ElevatedButton(
                onPressed: () => handler(),
                child: Text(label),
              )
            : TextButton(onPressed: () => handler(), child: Text(label))
        : isFilled
            ? CupertinoButton.filled(
                child: Text(label),
                onPressed: () => handler(),
              )
            : CupertinoButton(
                child: Text(label),
                onPressed: () => handler(),
              );
  }
}
