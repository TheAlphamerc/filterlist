library filter_list;

import 'package:flutter/material.dart';

import 'src/filter_list_widget.dart';

class FilterList {
  static Future<List<String>> showFilterList(
    context, {
    double height,
    double width,
    double borderRadius = 20,
    List<String> selectedTextList,
    List<String> allTextList,
    String headlineText = "Select here",
    String searchFieldHintText = "Search here",
    bool hideSelectedTextCount = false,
    bool hideSearchField = false,
    bool hidecloseIcon = false,
    bool hideheader = false,
    Color closeIconColor = Colors.black,
    Color headerTextColor = Colors.black,
    Color applyButonTextColor = Colors.white,
    Color applyButonTextBackgroundColor = Colors.blue,
    Color allResetButonColor = Colors.blue,
    Color selectedTextColor = Colors.white,
    Color backgroundColor = Colors.white,
    Color unselectedTextColor = Colors.black,
    Color searchFieldBackgroundColor = const Color(0xfff5f5f5),
    Color selectedTextBackgroundColor = Colors.blue,
    Color unselectedTextbackGroundColor = const Color(0xfff8f8f8),
  }) async {
    if (height == null) {
      height = MediaQuery.of(context).size.height * .8;
    }
    if (width == null) {
      width = MediaQuery.of(context).size.width;
    }
    var list = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: FilterListWidget(
              height: height,
              width: width,
              borderRadius: borderRadius,
              allTextList: allTextList,
              headlineText: headlineText,
              searchFieldHintText: searchFieldHintText,
              selectedTextList: selectedTextList,
              allResetButonColor: allResetButonColor,
              applyButonTextBackgroundColor: applyButonTextBackgroundColor,
              applyButonTextColor: applyButonTextColor,
              backgroundColor: backgroundColor,
              closeIconColor: closeIconColor,
              headerTextColor: headerTextColor,
              searchFieldBackgroundColor: searchFieldBackgroundColor,
              selectedTextBackgroundColor: selectedTextBackgroundColor,
              selectedTextColor: selectedTextColor,
              hideSelectedTextCount: hideSelectedTextCount,
              unselectedTextbackGroundColor: unselectedTextbackGroundColor,
              unselectedTextColor: unselectedTextColor,
              hidecloseIcon: hidecloseIcon,
              hideHeader: hideheader,
              hideSearchField: hideSearchField,
            ),
          ),
        );
      },
    );
    return list ?? selectedTextList;
  }
}
