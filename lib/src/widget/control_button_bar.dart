import 'package:filter_list/src/theme/theme.dart';
import 'package:filter_list/src/widget/control_button.dart';
import 'package:flutter/material.dart';

class ControlButtonBar extends StatelessWidget {
  const ControlButtonBar({
    Key? key,
    this.enableOnlySingleSelection = false,
    this.allButtonText,
    this.resetButtonText,
    this.applyButtonText,
    this.onApplyButtonClick,
    this.onResetButtonClick,
    this.onAllButtonClick,
  }) : super(key: key);
  final bool enableOnlySingleSelection;
  final String? allButtonText;
  final String? resetButtonText;
  final String? applyButtonText;
  final VoidCallback? onApplyButtonClick;
  final VoidCallback? onResetButtonClick;
  final VoidCallback? onAllButtonClick;

  @override
  Widget build(BuildContext context) {
    return ControlButtonBarTheme(
      data: FilterListTheme.of(context).controlBarButtonTheme,
      child: Builder(
        builder: (context) {
          final theme = ControlButtonBarTheme.of(context);
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: theme.height,
              margin: theme.margin,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: theme.controlContainerDecoration,
                padding: theme.padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ContorlButton(
                      choiceChipLabel: '$allButtonText',
                      onPressed: onAllButtonClick,
                    ),
                    SizedBox(width: theme.buttonSpacing),
                    ContorlButton(
                      choiceChipLabel: '$resetButtonText',
                      onPressed: onResetButtonClick,
                    ),
                    SizedBox(width: theme.buttonSpacing),
                    ContorlButton(
                      choiceChipLabel: '$applyButtonText',
                      primaryButton: true,
                      onPressed: onApplyButtonClick,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
