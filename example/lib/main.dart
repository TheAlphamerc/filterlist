import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter List Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Filter List Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});
  final String? title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<User>? selectedUserList = [];

  // Using the new FilterListDelegate.showWithCore implementation
  Future<void> openFilterDelegate() async {
    await FilterListDelegate.showWithCore<User>(
      context: context,
      allItems: userList,
      selectedItems: selectedUserList,
      callbacks: FilterCallbacks<User>(
        searchPredicate: (user, query) {
          return user.name!.toLowerCase().contains(query.toLowerCase());
        },
        validateSelection: (list, val) => list!.contains(val),
        labelProvider: (user) => user!.name,
        onApplyButtonClick: (list) {
          setState(() {
            selectedUserList = list;
          });
        },
      ),
      uiConfig: const FilterUIConfig(
        headlineText: 'Select Users',
        searchFieldHint: 'Search Here..',
        hideSelectedTextCount: false,
      ),
      theme: FilterListDelegateThemeData(
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          tileColor: Colors.white,
          selectedTileColor: const Color(0xFF649BEC).withOpacity(.5),
        ),
        tileTextStyle: const TextStyle(fontSize: 14),
      ),
      emptySearchChild: const Center(child: Text('No user found')),
    );
  }

  // Using the new FilterListDialog.showWithCore implementation
  Future<void> openFilterDialog() async {
    await FilterListDialog.showWithCore<User>(
      context,
      allItems: userList,
      selectedItems: selectedUserList,
      callbacks: FilterCallbacks<User>(
        searchPredicate: (user, query) {
          return user.name!.toLowerCase().contains(query.toLowerCase());
        },
        validateSelection: (list, val) => list!.contains(val),
        labelProvider: (user) => user!.name,
        onApplyButtonClick: (list) {
          setState(() {
            selectedUserList = List.from(list!);
          });
        },
      ),
      uiConfig: FilterUIConfig(
        headlineText: 'Select Users',
        hideSelectedTextCount: true,
        controlButtons: [
          ControlButtonType.All,
          ControlButtonType.Reset,
          ControlButtonType.Apply
        ],
        onClosePressed: () {
          Navigator.pop(context, null);
        },
      ),
      themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData.light(context),
      ),
      height: 500,
    );
  }

  // Using the modern implementation with Provider-based state management
  Future<void> openFilterDialogModern() async {
    // Create a proper theme
    final themeData = FilterListThemeData.light(context);

    // Use the modern dialog implementation now that we've fixed the theme issues
    final result = await FilterListDialog.showFilterListModern<User>(
      context,
      themeData: themeData,
      listData: userList,
      selectedListData: selectedUserList,
      labelProvider: (user) => user!.name,
      validateSelection: (list, val) => list!.contains(val),
      searchPredicate: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
      },
      headlineText: 'Select Users (Modern)',
      hideSelectedTextCount: false,
      enableOnlySingleSelection: false,
    );

    if (result != null) {
      setState(() {
        selectedUserList = result;
      });
    }
  }

  // Legacy implementation kept for comparison
  Future<void> _openFilterDialogLegacy() async {
    await FilterListDialog.display<User>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData.light(context),
      ),
      headlineText: 'Select Users (Legacy)',
      height: 500,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (item) => item!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },
      onCloseWidgetPress: () {
        Navigator.pop(context, null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FilledButton(
                  onPressed: () async {
                    final list = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterPageModern(
                          allItems: userList,
                          selectedItems: selectedUserList,
                        ),
                      ),
                    );
                    if (list != null) {
                      setState(() {
                        selectedUserList = List.from(list);
                      });
                    }
                  },
                  child: const Text("Modern Page"),
                ),
                FilledButton(
                  onPressed: openFilterDialog,
                  child: const Text("Core Dialog"),
                ),
                FilledButton(
                  onPressed: openFilterDelegate,
                  child: const Text("Core Delegate"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FilledButton(
                  onPressed: () async {
                    final list = await Navigator.push(
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
                  child: const Text("Legacy Page"),
                ),
                FilledButton(
                  onPressed: _openFilterDialogLegacy,
                  child: const Text("Legacy Dialog"),
                ),
                FilledButton(
                  onPressed: openFilterDialogModern,
                  child: const Text("Modern Dialog"),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          if (selectedUserList == null || selectedUserList!.isEmpty)
            const Expanded(
              child: Center(
                child: Text('No user selected'),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedUserList![index].name!),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: selectedUserList!.length,
              ),
            ),
        ],
      ),
    );
  }
}

// Legacy implementation
class FilterPage extends StatelessWidget {
  const FilterPage({super.key, this.allTextList, this.selectedUserList});
  final List<User>? allTextList;
  final List<User>? selectedUserList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legacy Filter Page')),
      body: SafeArea(
        child: FilterListWidget<User>(
          themeData: FilterListThemeData(context),
          hideSelectedTextCount: true,
          listData: userList,
          selectedListData: selectedUserList,
          onApplyButtonClick: (list) {
            Navigator.pop(context, list);
          },
          choiceChipLabel: (item) {
            return item!.name;
          },
          validateSelectedItem: (list, val) {
            return list!.contains(val);
          },
          onItemSearch: (user, query) {
            return user.name!.toLowerCase().contains(query.toLowerCase());
          },
          onCloseWidgetPress: () {
            debugPrint("hello");
          },
        ),
      ),
    );
  }
}

// Modern implementation using FilterListWidgetModern
class FilterPageModern extends StatelessWidget {
  const FilterPageModern({super.key, this.allItems, this.selectedItems});
  final List<User>? allItems;
  final List<User>? selectedItems;

  @override
  Widget build(BuildContext context) {
    // Create a complete theme using the light factory method
    final themeData = FilterListThemeData.light(context);

    // Create controller with all the necessary callbacks and configuration
    final controller = FilterListController<User>(
      allItems: allItems ?? userList,
      selectedItems: selectedItems,
      searchPredicate: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      validateSelection: (list, val) => list!.contains(val),
      onApplyButtonClick: (list) {
        Navigator.pop(context, list);
      },
      uiConfig: const FilterUIConfig(
        headlineText: 'Select Users (Modern)',
        hideSelectedTextCount: false,
        enableOnlySingleSelection: false,
      ),
    );

    // Use our improved FilterListWidgetModern with proper theme handling
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Filter Example'),
      ),
      body: FilterListProvider<User>(
        controller: controller,
        child: FilterListWidgetModern<User>(
          themeData: themeData,
        ),
      ),
    );
  }
}

class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<User> userList = [
  User(name: "Abigail", avatar: "user.png"),
  User(name: "Audrey", avatar: "user.png"),
  User(name: "Ava", avatar: "user.png"),
  User(name: "Bella", avatar: "user.png"),
  User(name: "Bernadette", avatar: "user.png"),
  User(name: "Carol", avatar: "user.png"),
  User(name: "Claire", avatar: "user.png"),
  User(name: "Deirdre", avatar: "user.png"),
  User(name: "Donna", avatar: "user.png"),
  User(name: "Dorothy", avatar: "user.png"),
  User(name: "Faith", avatar: "user.png"),
  User(name: "Gabrielle", avatar: "user.png"),
  User(name: "Grace", avatar: "user.png"),
  User(name: "Hannah", avatar: "user.png"),
  User(name: "Heather", avatar: "user.png"),
  User(name: "Irene", avatar: "user.png"),
  User(name: "Jan", avatar: "user.png"),
  User(name: "Jane", avatar: "user.png"),
  User(name: "Julia", avatar: "user.png"),
  User(name: "Kyle", avatar: "user.png"),
  User(name: "Lauren", avatar: "user.png"),
  User(name: "Leah", avatar: "user.png"),
  User(name: "Lisa", avatar: "user.png"),
  User(name: "Melanie", avatar: "user.png"),
  User(name: "Natalie", avatar: "user.png"),
  User(name: "Olivia", avatar: "user.png"),
  User(name: "Penelope", avatar: "user.png"),
  User(name: "Rachel", avatar: "user.png"),
  User(name: "Ruth", avatar: "user.png"),
  User(name: "Sally", avatar: "user.png"),
  User(name: "Samantha", avatar: "user.png"),
  User(name: "Sarah", avatar: "user.png"),
  User(name: "Theresa", avatar: "user.png"),
  User(name: "Una", avatar: "user.png"),
  User(name: "Vanessa", avatar: "user.png"),
  User(name: "Victoria", avatar: "user.png"),
  User(name: "Wanda", avatar: "user.png"),
  User(name: "Wendy", avatar: "user.png"),
  User(name: "Yvonne", avatar: "user.png"),
  User(name: "Zoe", avatar: "user.png"),
];

/// Another example of [FilterListWidget] to filter list of strings
/*
 FilterListWidget<String>(
    listData: [
      "One",
      "Two",
      "Three",
      "Four",
      "five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten"
    ],
    selectedListData: ["One", "Three", "Four", "Eight", "Nine"],
    onApplyButtonClick: (list) {
      Navigator.pop(context, list);
    },
    choiceChipLabel: (item) {
      /// Used to print text on chip
      return item;
    },
    validateSelectedItem: (list, val) {
      ///  identify if item is selected or not
      return list!.contains(val);
    },
    onItemSearch: (text, query) {
      return text.toLowerCase().contains(query.toLowerCase());
    },
  )
*/
