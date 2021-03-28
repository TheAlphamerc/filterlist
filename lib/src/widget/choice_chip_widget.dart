import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

class ChoiceChipWidget<T> extends StatelessWidget {
  const ChoiceChipWidget(
      {Key key,
      this.text,
      this.item,
      this.selected,
      this.onSelected,
      this.unselectedTextBackgroundColor,
      this.selectedTextBackgroundColor,
      this.choiceChipBuilder,
      this.selectedChipTextStyle,
      this.unselectedChipTextStyle})
      : super(key: key);

  final String text;
  final bool selected;
  final Function(bool) onSelected;
  final Color unselectedTextBackgroundColor;
  final Color selectedTextBackgroundColor;
  final TextStyle selectedChipTextStyle;
  final TextStyle unselectedChipTextStyle;
  final T item;

  /// Builder for custom choice chip
  final ChoiceChipBuilder choiceChipBuilder;

  TextStyle getSelectedTextStyle(BuildContext context) {
    return selected
        ? selectedChipTextStyle ??
            TextStyle(color: Theme.of(context).colorScheme.onPrimary)
        : unselectedChipTextStyle ?? TextStyle(color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return choiceChipBuilder != null
        ? GestureDetector(
            onTap: () {
              onSelected(true);
            },
            child: choiceChipBuilder(context, item, selected),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ChoiceChip(
              backgroundColor: selected
                  ? selectedTextBackgroundColor
                  : unselectedTextBackgroundColor,
              selectedColor: selected
                  ? selectedTextBackgroundColor
                  : unselectedTextBackgroundColor,
              label: Text(
                '$text',
                style: getSelectedTextStyle(context),
              ),
              selected: selected,
              onSelected: onSelected,
            ),
          );
  }
}
