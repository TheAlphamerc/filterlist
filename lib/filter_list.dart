library filter_list;

import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  FilterList(
      {Key key,
      this.selectedTextList,
      this.allTextList,
      this.headlineText = "Select here",
      this.searchFieldHintText = "Search here"})
      : super(key: key);
  final List<String> selectedTextList;
  final List<String> allTextList;

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
    _allTextList = List.from(widget.allTextList);
    _selectedTextList = widget.selectedTextList != null
        ? List.from(widget.selectedTextList)
        : [];
    super.initState();
  }

  bool showApplyButton = false;
 
  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5),
            child: Container(
               decoration: BoxDecoration(
              color: Colors.white,
                boxShadow: <BoxShadow>[
                            BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 15,
                              color: Color(0x12000000),
                            )
                ]
              ),
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
                    Material(
                      // need Material wrapper for the TextField
                      color: Colors
                          .transparent, // get rid of Materials background color
                      child: Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.shade200),
                        child: TextField(
                          onChanged: (value) {
                            // update list based on text
                            setState(() {
                              _allTextList = _allTextList
                                  .where((string) => string
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.search, color: Colors.black38),
                            hintText: widget.searchFieldHintText,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              '${_selectedTextList.length} selected items',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 0, bottom: 60, left: 5, right: 5),
            child: SingleChildScrollView(
              child: Wrap(
                children: _buildChoiceList(_allTextList),
              ),
            ),
          )),
           _controlButon() 
        ],
      ),
    );
  }

  Widget _controlButon() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * .9,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(child: SizedBox()),
            Container(
              //  borderRadiusValue: 40,
             
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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

  List<Widget> _buildChoiceList(List<String> list) {
    List<Widget> choices = List();
    list.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ChoiceChip(
          backgroundColor: Colors.grey.shade100,
          selectedColor: Colors.blue,
          label: _selectedTextList.contains(item)
              ? Text(
                  '$item',
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  '$item',
                ),
          selected: _selectedTextList.contains(item),
          onSelected: (selected) {
            setState(() {
              _selectedTextList.contains(item)
                  ? _selectedTextList.remove(item)
                  : _selectedTextList.add(item);
              onSelectionChanged(_selectedTextList);
            });
          },
        ),
      ));
    });
    var wrap = list == null || list.length == 0
        ? Container()
        : Wrap(
            children: choices,
          );

    return choices;
  }

  onSelectionChanged(List<String> list) {}
}
