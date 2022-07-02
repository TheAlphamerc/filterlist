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
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(theme.borderRadius)),
        )),
        backgroundColor: MaterialStateProperty.all(
          primaryButton
              ? theme.primaryButtonBackgroundColor
              : theme.backgroundColor,
        ),
        elevation: MaterialStateProperty.all(theme.elevation),
        foregroundColor: MaterialStateProperty.all(
          primaryButton
              ? theme.primaryButtonTextStyle!.color
              : theme.textStyle!.color,
        ),
        textStyle: MaterialStateProperty.all(
          primaryButton ? theme.primaryButtonTextStyle : theme.textStyle,
        ),
        padding: MaterialStateProperty.all(theme.padding),
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
