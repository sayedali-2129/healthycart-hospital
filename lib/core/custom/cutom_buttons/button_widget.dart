import 'package:flutter/material.dart';

//Colored Button
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.buttonColor,
    required this.buttonWidget,
    this.onPressed,
  });
  final double buttonHeight;
  final double buttonWidth;
  final Color buttonColor;
  final Widget buttonWidget;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(buttonColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: buttonWidget),
    );
  }
}
