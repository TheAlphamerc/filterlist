import 'package:filter_list/filter_list.dart';
import 'package:filter_list/src/state/filter_state.dart';
import 'package:filter_list/src/state/provider.dart';

import 'package:filter_list/src/widget/control_button.dart';
import 'package:flutter/material.dart';

class ControlButtonBar<T> extends StatelessWidget {
  const ControlButtonBar({
    Key? key,
    this.enableOnlySingleSelection = false,
    this.allButtonText,
    this.resetButtonText,
    this.applyButtonText,
    this.onApplyButtonClick,
    required this.controlButtons,
  }) : super(key: key);
  final bool enableOnlySingleSelection;
  final String? allButtonText;
  final String? resetButtonText;
  final String? applyButtonText;
  final VoidCallback? onApplyButtonClick;

  /// {@macro control_buttons}
  final List<ContolButtonType> controlButtons;

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
                    /* All Button */
                    if (!enableOnlySingleSelection &&
                        controlButtons.contains(ContolButtonType.All)) ...[
                      ContorlButton(
                        choiceChipLabel: '$allButtonText',
                        onPressed: () {
                          final state = StateProvider.of<FilterState<T>>(
                            context,
                            rebuildOnChange: true,
                          );
                          state.selctedItems = state.items;
                        },
                      ),
                      SizedBox(width: theme.buttonSpacing),

                      /* Reset Button */
                    ],
                    if (controlButtons.contains(ContolButtonType.Reset)) ...[
                      ContorlButton(
                        choiceChipLabel: '$resetButtonText',
                        onPressed: () {
                          final state = StateProvider.of<FilterState<T>>(
                            context,
                            rebuildOnChange: true,
                          );
                          state.selctedItems = [];
                        },
                      ),
                      SizedBox(width: theme.buttonSpacing),
                    ],
                    /* Apply Button */
                    ContorlButton(
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
