import "dart:io" show Platform;

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String label;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: () => onPressed(),
            child: Text(label),
          )
        : GestureDetector(
            onTap: () => onPressed(),
            child: Container(
              width: MediaQuery.of(context).size.width > 600 ? 300 : 160,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color(0xFFFFC942),
              ),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}
