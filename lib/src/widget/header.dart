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
    this.onCloseWidgetPress,
  }) : super(key: key);

  final String? headlineText;
  final bool hideCloseIcon;
  final Widget? headerCloseIcon;
  final bool hideSearchField;
  final ValueChanged<String> onSearch;
  final void Function()? onCloseWidgetPress;

  @override
  Widget build(BuildContext context) {
    final headerTheme = FilterListTheme.of(context).headerTheme;
    return Container(
      decoration: BoxDecoration(
          color: headerTheme.backgroundColor, boxShadow: headerTheme.boxShadow),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Expanded(
                  child: SizedBox(),
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
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    onTap: onCloseWidgetPress ??
                        () {
                          Navigator.pop(context);
                        },
                    child: hideCloseIcon
                        ? const SizedBox()
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
                                size: 16,
                                color: headerTheme.closeIconColor,
                              ),
                            ),
                  ),
                ),
              ],
            ),
            if (!hideSearchField) ...[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SearchFieldWidget(onChanged: onSearch),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
