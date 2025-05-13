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
    await FilterListDelegateExtension.showWithCore<User>(
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
          ControlButtonType.all,
          ControlButtonType.reset,
          ControlButtonType.apply
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
      controlButtons: [ControlButtonType.all, ControlButtonType.reset],
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
                  child:
                      const Text("Open Filter Page\n(Direct FilterOperations)"),
                ),
                FilledButton(
                  onPressed: openFilterDelegate,
                  child: const Text("Filter Delegate\n(Core Implementation)"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FilledButton(
                  onPressed: openFilterDialog,
                  child: const Text("Filter Dialog\n(Core Implementation)"),
                ),
                FilledButton(
                  onPressed: openFilterDialogModern,
                  child: const Text("Modern Filter\n(Provider Implementation)"),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              selectedUserList!.isEmpty
                  ? "No users selected"
                  : "${selectedUserList!.length} users selected",
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: selectedUserList!.isEmpty
                ? const Center(
                    child: Text("Select users using the buttons below"))
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            selectedUserList![index].name!.substring(0, 1),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(selectedUserList![index].name!),
                        subtitle: Text(
                            "Selected from filter list (${index + 1} of ${selectedUserList!.length})"),
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

// Modern implementation with direct FilterOperations usage
class FilterPageModern extends StatefulWidget {
  final List<User> allItems;
  final List<User>? selectedItems;

  const FilterPageModern({
    super.key,
    required this.allItems,
    this.selectedItems,
  });

  @override
  _FilterPageModernState createState() => _FilterPageModernState();
}

class _FilterPageModernState extends State<FilterPageModern> {
  late FilterOperations<User> _filterOperations;
  List<User> _filteredItems = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filterOperations = FilterCore<User>(
      allItems: widget.allItems,
      selectedItems: widget.selectedItems,
      searchPredicate: (user, query) {
        return user.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
      },
      validateSelection: (list, user) =>
          list?.any((selectedUser) => selectedUser.name == user.name) ?? false,
    );
    _filteredItems = _filterOperations.allItems;
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
      _filteredItems = _filterOperations.filter(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Page (Direct FilterOperations)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, _filterOperations.selectedItems);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _updateSearchQuery,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_filterOperations.selectedItemsCount} items selected",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _filterOperations.selectAll();
                        });
                      },
                      child: const Text("Select All"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _filterOperations.clearSelection();
                        });
                      },
                      child: const Text("Clear"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final user = _filteredItems[index];
                final isSelected = _filterOperations.isItemSelected(user);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isSelected ? Colors.blue : Colors.grey,
                    child: Text(
                      user.name!.substring(0, 1),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(user.name!),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : const Icon(Icons.circle_outlined),
                  selected: isSelected,
                  onTap: () {
                    setState(() {
                      _filterOperations.toggleItem(user);
                    });
                  },
                );
              },
            ),
          ),
        ],
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
