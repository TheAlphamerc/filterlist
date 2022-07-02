import 'package:filter_list/src/theme/filter_list_theme.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget<T> extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchFieldWidget({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerTheme = FilterListTheme.of(context).headerTheme;
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(headerTheme.searchFieldBorderRadius),
          color: headerTheme.searchFieldBackgroundColor,
        ),
        child: TextField(
          onChanged: onChanged,
          style: headerTheme.searchFieldTextStyle,
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.search, color: headerTheme.searchFieldIconColor),
            hintText: headerTheme.searchFieldHintText,
            hintStyle: headerTheme.searchFieldHintTextStyle,
            border: headerTheme.searchFieldInputBorder,
          ),
        ),
      ),
    );
  }
}
