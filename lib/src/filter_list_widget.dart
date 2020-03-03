import 'package:filter_list/src/choice_chip_widget.dart';
import 'package:filter_list/src/search_field_widget.dart';
import 'package:flutter/material.dart';

class FilterListWidget extends StatefulWidget {
  FilterListWidget({
    Key key,
    this.borderRadius,
    this.height,
    this.width,
    this.selectedTextList,
    this.allTextList,
    this.headlineText,
    this.searchFieldHintText,
    this.closeIconColor,
    this.headerTextColor,
    this.applyButonTextColor,
    this.applyButonTextBackgroundColor,
    this.allResetButonColor,
    this.selectedTextColor,
    this.backgroundColor,
    this.unselectedTextColor,
    this.searchFieldBackgroundColor,
    this.selectedTextBackgroundColor,
    this.unselectedTextbackGroundColor,
    this.hideHeader,
    this.hideSearchField,
    this.hidecloseIcon,
    this.hideSelectedTextCount,
  }) : super(key: key);
  final double height;
  final double width;
  final double borderRadius;
  final List<String> selectedTextList;
  final List<String> allTextList;
  final Color closeIconColor;
  final Color headerTextColor;
  final Color backgroundColor;
  final Color applyButonTextColor;
  final Color applyButonTextBackgroundColor;
  final Color allResetButonColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color searchFieldBackgroundColor;
  final Color selectedTextBackgroundColor;
  final Color unselectedTextbackGroundColor;

  final String headlineText;
  final String searchFieldHintText;
  final bool hideSelectedTextCount;
  final bool hideSearchField;
  final bool hidecloseIcon;
  final bool hideHeader;

  @override
  _FilterListWidgetState createState() => _FilterListWidgetState();
}

class _FilterListWidgetState extends State<FilterListWidget> {
  List<String> _selectedTextList = List();

  List<String> _allTextList;

  @override
  void initState() {
    _allTextList =
        widget.allTextList == null ? [] : List.from(widget.allTextList);
    _selectedTextList = widget.selectedTextList != null
        ? List.from(widget.selectedTextList)
        : [];
    super.initState();
  }

  bool showApplyButton = false;

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              widget.hideHeader ? SizedBox() : _header(),
              widget.hideSelectedTextCount
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '${_selectedTextList.length} selected items',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                child: SingleChildScrollView(
                  child: Wrap(
                    children: _buildChoiceList(_allTextList),
                  ),
                ),
              )),
            ],
          ),
          _controlButon()
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 15,
              color: Color(0x12000000),
            )
          ],
        ),
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
                    child: Container(),
                  ),
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: Text(
                        widget.headlineText.toUpperCase(),
                        style: Theme.of(context).textTheme.headline.copyWith(
                            fontSize: 18, color: widget.headerTextColor),
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
                      child: widget.hidecloseIcon
                          ? SizedBox()
                          : Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: widget.closeIconColor),
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.close,
                                color: widget.closeIconColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              widget.hideSearchField
                  ? SizedBox()
                  : SizedBox(
                      height: 10,
                    ),
              widget.hideSearchField
                  ? SizedBox()
                  : SearchFieldWidget(
                      searchFieldBackgroundColor:
                          widget.searchFieldBackgroundColor,
                      searchFieldHintText: widget.searchFieldHintText,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {}
                          _allTextList = widget.allTextList
                              .where((string) => string
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChoiceList(List<String> list) {
    List<Widget> choices = List();
    list.forEach(
      (item) {
        var selectedText = _selectedTextList.contains(item);
        choices.add(
          ChoicechipWidget(
            onSelected: (value) {
              setState(
                () {
                  selectedText
                      ? _selectedTextList.remove(item)
                      : _selectedTextList.add(item);
                },
              );
            },
            selected: selectedText,
            selectedTextColor: widget.selectedTextColor,
            selectedTextBackgroundColor: widget.selectedTextBackgroundColor,
            unselectedTextBackgroundColor: widget.unselectedTextbackGroundColor,
            unselectedTextColor: widget.unselectedTextColor,
            text: item,
          ),
        );
      },
    );
    choices.add(
      SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
      ),
    );
    return choices;
  }

  Widget _controlButon() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * .9,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(child: SizedBox()),
            Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 15,
                    color: Color(0x12000000),
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          _selectedTextList = List.from(_allTextList);
                        },
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'All',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            fontSize: 20, color: widget.allResetButonColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTextList.clear();
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'Reset',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            fontSize: 20, color: widget.allResetButonColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: widget.applyButonTextBackgroundColor,
                    padding: EdgeInsets.only(bottom: 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    onPressed: () {
                      Navigator.pop(context, _selectedTextList);
                    },
                    child: Center(
                      child: Text(
                        'Apply',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            fontSize: 20, color: widget.applyButonTextColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /// add Bottom space in list
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        child: Container(
          height: widget.height,
          width: widget.width,
          padding: EdgeInsets.only(bottom: 3, top: 3),
          color: widget.backgroundColor,
          child: Stack(
            children: <Widget>[
              _body(),
            ],
          ),
        ),
      ),
    );
  }
}
