import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

class ChoiceChipWidget<T> extends StatelessWidget {
  const ChoiceChipWidget({
    Key? key,
    this.text,
    this.item,
    this.selected,
    this.onSelected,
    this.choiceChipBuilder,
    this.disabled = false,
  }) : super(key: key);

  final String? text;
  final bool? selected;
  final void Function(bool)? onSelected;
  final T? item;
  final bool disabled;

  /// Builder for custom choice chip
  final ChoiceChipBuilder? choiceChipBuilder;

  TextStyle? getSelectedTextStyle(BuildContext context) {
    return selected!
        ? FilterListTheme.of(context).choiceChipTheme.selectedTextStyle
        : FilterListTheme.of(context).choiceChipTheme.textStyle;
  }

  Color? getBackgroundColor(BuildContext context) {
    return selected!
        ? FilterListTheme.of(context).choiceChipTheme.selectedBackgroundColor
        : FilterListTheme.of(context).choiceChipTheme.backgroundColor;
  }

  OutlinedBorder? getShape(BuildContext context) {
    return selected!
        ? FilterListTheme.of(context).choiceChipTheme.selectedShape
        : FilterListTheme.of(context).choiceChipTheme.shape;
  }

  BorderSide? getSide(BuildContext context) {
    return selected!
        ? FilterListTheme.of(context).choiceChipTheme.selectedSide
        : FilterListTheme.of(context).choiceChipTheme.side;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FilterListTheme.of(context).choiceChipTheme;
    return choiceChipBuilder != null
        ? GestureDetector(
            onTap: () => onSelected!(true),
            child: choiceChipBuilder!(context, item, selected),
          )
        : Padding(
            padding: theme.margin,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
              ),
              child: ChoiceChip(
                labelPadding: theme.labelPadding,
                padding: theme.padding,
                backgroundColor: getBackgroundColor(context),
                selectedColor: theme.selectedBackgroundColor,
                label: Text('$text'),
                labelStyle: getSelectedTextStyle(context),
                visualDensity: theme.visualDensity,
                selected: selected!,
                onSelected: disabled ? null : onSelected,
                elevation: theme.elevation,
                side: getSide(context),
                shape: getShape(context),
                shadowColor: theme.shadowColor,
                selectedShadowColor: theme.selectedShadowColor,
              ),
            ),
          );
  }
}
