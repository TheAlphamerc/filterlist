import 'package:filter_list/src/theme/theme.dart';
import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({
    Key? key,
    required this.choiceChipLabel,
    this.onPressed,
    this.primaryButton = false,
  }) : super(key: key);
  final String choiceChipLabel;
  final VoidCallback? onPressed;
  final bool primaryButton;

  @override
  Widget build(BuildContext context) {
    // Get the button theme using the safer methods
    ControlButtonThemeData effectiveTheme;

    // Check for direct theme first
    final directTheme =
        context.dependOnInheritedWidgetOfExactType<ControlButtonTheme>()?.data;
    if (directTheme != null) {
      effectiveTheme = directTheme;
    } else {
      // If not available, try to get from control button bar theme
      final barTheme = ControlButtonBarTheme.safeOf(context);
      effectiveTheme = barTheme.controlButtonTheme;
    }

    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(effectiveTheme.borderRadius)),
        )),
        backgroundColor: WidgetStateProperty.all(
          primaryButton
              ? effectiveTheme.primaryButtonBackgroundColor
              : effectiveTheme.backgroundColor,
        ),
        elevation: WidgetStateProperty.all(effectiveTheme.elevation),
        foregroundColor: WidgetStateProperty.all(
          primaryButton
              ? effectiveTheme.primaryButtonTextStyle!.color
              : effectiveTheme.textStyle!.color,
        ),
        textStyle: WidgetStateProperty.all(
          primaryButton
              ? effectiveTheme.primaryButtonTextStyle
              : effectiveTheme.textStyle,
        ),
        padding: WidgetStateProperty.all(effectiveTheme.padding),
      ),
      onPressed: onPressed,
      clipBehavior: Clip.antiAlias,
      child: Text(
        choiceChipLabel,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
