import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  List<User> selectedUserList = [];

  void _openFilterDialog() async {
    await FilterListDialog.display(context,
        allButonText: 'Todos',
        listData: userList,
        selectedListData: selectedUserList,
        label: (item) {
          return item.name;
        },
        validateSelectedItem: (list, val) {
          return list.contains(val);
        },
        onItemSearch: (list, text) {
          /// When text change in search text field then return list containing that text value
          ///
          ///Check if list has value which matchs to text
          if (list.any((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))) {
            /// return list which contains matches
            return list
                .where((element) =>
                    element.name.toLowerCase().contains(text.toLowerCase()))
                .toList();
          }
        },
        height: 480,
        borderRadius: 20,
        headlineText: "Select Count123",
        searchFieldHintText: "Search Here",
        onApplyButtonClick: (list) {
          if (list != null) {
            setState(() {
              selectedUserList = List.from(list);
            });
            Navigator.pop(context);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              var list = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterPage(
                    allTextList: userList,
                    selectedUserList: selectedUserList,
                  ),
                ),
              );
              if (list != null) {
                setState(() {
                  selectedUserList = List.from(list);
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
            onPressed: _openFilterDialog,
            child: Text(
              "Filter Dialog",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          selectedUserList == null || selectedUserList.length == 0
              ? Expanded(
                  child: Center(
                    child: Text('No text selected'),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(selectedUserList[index].name),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: selectedUserList.length),
                ),
        ],
      ),
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({Key key, this.allTextList, this.selectedUserList})
      : super(key: key);
  final List<User> allTextList;
  final List<User> selectedUserList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter list Page"),
      ),
      body: SafeArea(
        child: FilterListWidget(
          listData: userList,
          selectedListData: selectedUserList,
          hideheaderText: true,
          onApplyButtonClick: (list) {
            Navigator.pop(context, list);
          },
          label: (item) {
            /// Used to print text on chip
            return item.name;
          },
          validateSelectedItem: (list, val) {
            ///  identify if item is selected or not
            return list.contains(val);
          },
          onItemSearch: (list, text) {
            /// When text change in search text field then return list containing that text value
            ///
            ///Check if list has value which matchs to text
            if (list.any((element) =>
                element.name.toLowerCase().contains(text.toLowerCase()))) {
              /// return list which contains matches
              return list
                  .where((element) =>
                      element.name.toLowerCase().contains(text.toLowerCase()))
                  .toList();
            }
          },
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String avatar;
  User({this.name, this.avatar});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or whereever you want
List<User> userList = [
  User(name: "Jon", avatar: "asd"),
  User(name: "Lindsey ", avatar: "asd"),
  User(name: "Valarie ", avatar: "asd"),
  User(name: "Elyse ", avatar: "asd"),
  User(name: "Ethel ", avatar: "asd"),
  User(name: "Emelyan ", avatar: "asd"),
  User(name: "Catherine ", avatar: "asd"),
  User(name: "Stepanida  ", avatar: "asd"),
  User(name: "Carolina ", avatar: "asd"),
  User(name: "Nail  ", avatar: "asd"),
];

/// Another exmaple of [FilterListWidget] to filter list of strings
///
/// FilterListWidget(
///   listData: ["One", "Two", "Three", "Four","five","Six","Seven","Eight","Nine","Ten"],
///   selectedListData: ["One", "Three", "Four","Eight","Nine"],
///   hideheaderText: true,
///   height: MediaQuery.of(context).size.height,
///   // hideheaderText: true,
///   onApplyButtonClick: (list) {
///     Navigator.pop(context, list);
///   },
///   label: (item) {
///     /// Used to print text on chip
///     return item;
///   },
///   validateSelectedItem: (list, val) {
///     ///  identify if item is selected or not
///     return list.contains(val);
///   },
///   onItemSearch: (list, text) {
///     /// When text change in search text field then return list containing that text value
///     ///
///     ///Check if list has value which matchs to text
///     if (list.any((element) =>
///         element.toLowerCase().contains(text.toLowerCase()))) {
///       /// return list which contains matches
///       return list
///           .where((element) =>
///               element.toLowerCase().contains(text.toLowerCase()))
///           .toList();
///     }
///   },
/// )
