import 'package:filter_list/filter_list.dart';
import 'package:filter_list/src/state/filter_state.dart';
import 'package:filter_list/src/state/provider.dart';

import 'package:filter_list/src/widget/control_button.dart';
import 'package:flutter/material.dart';

/// {@template control_buttons}
/// control buttons to show on bottom of dialog along with 'Apply' button.
/// Generally used to show 'All', 'Reset' and 'Apply' button.
/// {@endtemplate}
class ControlButtonBar<T> extends StatelessWidget {
  const ControlButtonBar({
    Key? key,
    this.enableOnlySingleSelection = false,
    this.allButtonText,
    this.resetButtonText,
    this.applyButtonText,
    this.onApplyButtonClick,
    this.maximumSelectionLength,
    required this.controlButtons,
  }) : super(key: key);
  final bool enableOnlySingleSelection;
  final String? allButtonText;
  final String? resetButtonText;
  final String? applyButtonText;
  final VoidCallback? onApplyButtonClick;
  final int? maximumSelectionLength;

  /// {@macro control_buttons}
  final List<ControlButtonType> controlButtons;

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
                decoration: theme.controlContainerDecoration!.copyWith(
                  color: theme.controlContainerDecoration!.color ??
                      theme.backgroundColor,
                ),
                padding: theme.padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    /* All Button */
                    if (maximumSelectionLength == null &&
                        !enableOnlySingleSelection &&
                        controlButtons.contains(ControlButtonType.All)) ...[
                      ControlButton(
                        choiceChipLabel: '$allButtonText',
                        onPressed: () {
                          final state = StateProvider.of<FilterState<T>>(
                            context,
                            rebuildOnChange: true,
                          );
                          state.selectedItems = state.items;
                        },
                      ),
                      SizedBox(width: theme.buttonSpacing),

                      /* Reset Button */
                    ],
                    if (controlButtons.contains(ControlButtonType.Reset)) ...[
                      ControlButton(
                        choiceChipLabel: '$resetButtonText',
                        onPressed: () {
                          final state = StateProvider.of<FilterState<T>>(
                            context,
                            rebuildOnChange: true,
                          );
                          state.selectedItems = [];
                        },
                      ),
                      SizedBox(width: theme.buttonSpacing),
                    ],
                    /* Apply Button */
                    ControlButton(
                      choiceChipLabel: '$applyButtonText',
                      primaryButton: true,
                      onPressed: () {
                        onApplyButtonClick?.call();
                      },
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
