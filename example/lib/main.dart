import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Filter list plugin demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> countList = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Eleven",
    "Tweleve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "Sixteen",
    "Seventeen",
    "Eighteen",
    "Nineteen",
    "Twenty"
  ];
  List<String> selectedCountList = [];

  void _openFilterList() async {
    var list = await FilterListDialog.display(
      context,
      allTextList: countList,
      height: 480,
      borderRadius: 20,
      headlineText: "Select Count",
      searchFieldHintText: "Search Here",
      selectedTextList: selectedCountList,
      onApplyButtonClick:(list){
        print("Get list data");
      }
    );

    if (list != null) {
      setState(() {
        selectedCountList = List.from(list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          selectedCountList == null || selectedCountList.length == 0
              ? Expanded(
                  child: Center(
                    child: Text('No text selected'),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(selectedCountList[index]),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: selectedCountList.length),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  var list = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilterPage(
                        allTextList: countList,
                      ),
                    ),
                  );
                  if (list != null) {
                    setState(() {
                      selectedCountList = List.from(list);
                    });
                  }
                },
                child: Text(
                  "Filter Page",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: _openFilterList,
                child: Text(
                  "Filter Dialog",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({Key key, this.allTextList}) : super(key: key);
  final List<String> allTextList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter list Page"),
      ),
      body: SafeArea(
        child: FilterListWidget(
          allTextList: allTextList,
          height: MediaQuery.of(context).size.height,
          hideheaderText: true,
          onApplyButtonClick: (list) {
            Navigator.pop(context, list);
          },
        ),
      ),
    );
  }
}
