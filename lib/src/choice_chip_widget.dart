import 'package:flutter/material.dart';

class ChoicechipWidget extends StatelessWidget {
  const ChoicechipWidget(
      {Key key,
      this.text,
      this.selected,
      this.selectedTextColor,
      this.unselectedTextColor,
      this.onSelected,
      this.unselectedTextBackgroundColor,
      this.selectedTextBackgroundColor})
      : super(key: key);

  final String text;
  final bool selected;
  final Function(bool) onSelected;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color unselectedTextBackgroundColor;
  final Color selectedTextBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: selected ? selectedTextColor : unselectedTextColor),
          ),
          selected: selected,
          onSelected: onSelected),
    );
  }
}
