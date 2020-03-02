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
    var list = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width,
            child: FilterList(
              allTextList: countList,
              headlineText: "Select Count",
              searchFieldHintText: "Search Here",
              selectedTextList: selectedCountList,
            ),
          ),
        );
      },
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
        floatingActionButton: FloatingActionButton(
          onPressed: _openFilterList,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        body: selectedCountList == null || selectedCountList.length == 0
            ? Center(
                child: Text('No text selected'),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedCountList[index]),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: selectedCountList.length));
  }
}
