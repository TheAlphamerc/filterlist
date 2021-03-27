import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

class ChoiceChipWidget<T> extends StatelessWidget {
  const ChoiceChipWidget(
      {Key key,
      this.text,
      this.item,
      this.selected,
      this.selectedTextColor,
      this.unselectedTextColor,
      this.onSelected,
      this.unselectedTextBackgroundColor,
      this.selectedTextBackgroundColor,
      this.choiceChipBuilder})
      : super(key: key);

  final String text;
  final bool selected;
  final Function(bool) onSelected;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color unselectedTextBackgroundColor;
  final Color selectedTextBackgroundColor;
  final T item;

  /// Builder for custom choice chip
  final ChoiceChipBuilder choiceChipBuilder;
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
                  style: TextStyle(
                      color:
                          selected ? selectedTextColor : unselectedTextColor),
                ),
                selected: selected,
                onSelected: onSelected),
          );
  }
}
