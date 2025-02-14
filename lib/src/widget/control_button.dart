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
    final theme = ControlButtonTheme.of(context);
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(theme.borderRadius)),
        )),
        backgroundColor: WidgetStateProperty.all(
          primaryButton
              ? theme.primaryButtonBackgroundColor
              : theme.backgroundColor,
        ),
        elevation: WidgetStateProperty.all(theme.elevation),
        foregroundColor: WidgetStateProperty.all(
          primaryButton
              ? theme.primaryButtonTextStyle!.color
              : theme.textStyle!.color,
        ),
        textStyle: WidgetStateProperty.all(
          primaryButton ? theme.primaryButtonTextStyle : theme.textStyle,
        ),
        padding: WidgetStateProperty.all(theme.padding),
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
