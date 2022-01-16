import 'package:filter_list/filter_list.dart';
import 'package:filter_list/src/widget/search_field_widget.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.onSearch,
    this.headlineText,
    this.hideCloseIcon = false,
    this.headerCloseIcon,
    this.hideSearchField = false,
  }) : super(key: key);

  final String? headlineText;
  final bool hideCloseIcon;
  final Widget? headerCloseIcon;
  final bool hideSearchField;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    final headerTheme = FilterListTheme.of(context).headerTheme;
    return Container(
      decoration: BoxDecoration(
          color: headerTheme.backgroundColor, boxShadow: headerTheme.boxShadow),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: const SizedBox.shrink(),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: headlineText == null
                        ? const SizedBox.shrink()
                        : Text(
                            headlineText!,
                            style: headerTheme.headerTextStyle,
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                    child: hideCloseIcon
                        ? SizedBox()
                        : headerCloseIcon ??
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: headerTheme.closeIconColor,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: headerTheme.closeIconColor,
                              ),
                            ),
                  ),
                ),
              ],
            ),
            hideSearchField ? SizedBox() : SizedBox(height: 10),
            hideSearchField
                ? SizedBox()
                : SearchFieldWidget(onChanged: onSearch)
          ],
        ),
      ),
    );
  }
}
