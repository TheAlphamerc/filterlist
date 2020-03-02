library filter_list;

import 'package:flutter/material.dart';

import 'src/choice_chip_widget.dart';
import 'src/search_field_widget.dart';

class FilterList extends StatefulWidget {
  FilterList({
    Key key,
    this.selectedTextList,
    this.allTextList,
    this.headlineText = "Select here",
    this.searchFieldHintText = "Search here",
    this.showSelectedTextCount = true,
    this.closeIconColor = Colors.black,
    this.headerTextColor = Colors.black,
    this.applyButonColor = Colors.blue,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.black,
    this.searchFieldBackgroundColor = const Color(0xfff8f8f8),
    this.selectedTextBackgroundColor = Colors.blue,
    this.unselectedTextbackGroundColor = const Color(0xfff8f8f8),
  }) : super(key: key);
  final List<String> selectedTextList;
  final List<String> allTextList;
  final bool showSelectedTextCount;
  final Color closeIconColor;
  final Color headerTextColor;
  final Color applyButonColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color searchFieldBackgroundColor;
  final Color selectedTextBackgroundColor;
  final Color unselectedTextbackGroundColor;

  final String headlineText;
  final String searchFieldHintText;

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
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
                _header(),
                !widget.showSelectedTextCount
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
                  padding:
                      EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
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
        ));
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 15,
            color: Color(0x12000000),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(fontSize: 18),
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      onTap: () {
                        Navigator.pop(context, List<String>());
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87),
                            shape: BoxShape.circle),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SearchFieldWidget(
                searchFieldHintText: widget.searchFieldHintText,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {}
                    _allTextList = widget.allTextList
                        .where((string) =>
                            string.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
              )
              // _searchField()
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
        choices.add(ChoicechipWidget(
          onSelected: (value) {
            setState(() {
              selectedText
                  ? _selectedTextList.remove(item)
                  : _selectedTextList.add(item);
            });
          },
          selected: selectedText,
          selectedTextColor: widget.selectedTextColor,
          unselectedTextColor: widget.unselectedTextColor,
          text: item,
        ));
      },
    );
    choices.add(SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
    ));
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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 15,
                      color: Color(0x12000000),
                    )
                  ]),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTextList = List.from(_allTextList);
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'All',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 20, color: Colors.blue),
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
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 20, color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.only(bottom: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      onPressed: () {
                        Navigator.pop(context, _selectedTextList);
                      },
                      child: Center(
                        child: Text(
                          'Apply',
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ))
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 3, top: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Stack(
          children: <Widget>[
            _body(),
          ],
        ),
      ),
    );
  }
}
