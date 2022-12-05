
## filter_list  
[![pub package](https://img.shields.io/pub/v/filter_list?color=blue)](https://pub.dev/packages/filter_list) 
[![Likes](https://badges.bar/filter_list/likes)](https://pub.dev/packages/flutter_plugin_filter_list/score)
[![Popularity](https://badges.bar/filter_list/popularity)](https://pub.dev/packages/filter_list/score)
[![Pub points](https://badges.bar/flutter_week_view/pub%20points)](https://pub.dev/packages/filter_list/score)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FTheAlphamerc%2Fflutter_plugin_filter_list&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_filter_list?style=social)](https://github.com/login?return_to=https://github.com/FTheAlphamerc/flutter_plugin_filter_list) 
![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/flutter_plugin_filter_list?style=social)


FilterList is a flutter package which provide utility to search/filter on the basis of single/multiple selection from provided dynamic list.

### Download Demo App ![GitHub All Releases](https://img.shields.io/github/downloads/Thealphamerc/flutter_plugin_filter_list/total?color=green)
<a href="https://github.com/TheAlphamerc/flutter_plugin_filter_list/releases/download/v1.0.1/app-release.apk"><img src="https://playerzon.com/asset/download.png" width="200"></img></a>

## Getting Started
1. Add library to your pubspec.yaml
```yaml

dependencies:
  filter_list: ^<latest_version>

```
2. Import library in dart file
```dart
import 'package:filter_list/filter_list.dart';
```

3. Create a list of Strings / dynamic object
``` dart
class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

List<User> userList = [
 User(name: "Jon", avatar: ""),
  User(name: "Lindsey ", avatar: ""),
  User(name: "Valarie ", avatar: ""),
  User(name: "Elyse ", avatar: ""),
  User(name: "Ethel ", avatar: ""),
  User(name: "Emelyan ", avatar: ""),
  User(name: "Catherine ", avatar: ""),
  User(name: "Stepanida  ", avatar: ""),
  User(name: "Carolina ", avatar: ""),
  User(name: "Nail  ", avatar: ""),
  User(name: "Kamil ", avatar: ""),
  User(name: "Mariana ", avatar: ""),
  User(name: "Katerina ", avatar: ""),
];
```

## Filter list offer 3 ways to filter data from list
- FilterListDialog
- FilterListWidget
- FilterListDelegate

Below is a example of using filter list widgets with minimal code however there is a lot more inside the widget for you to fully customize the widget.

##  How to use FilterListDialog
#### 1. Create a function and call `FilterListDialog.display`  
```dart
  void openFilterDialog() async {
    await FilterListDialog.display<User>(
      context,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }
```
>If `Apply` button is pressed without making any selection  it will return empty list of items.

#### 2. Call `openFilterDialog` function on button tap to display filter dialog

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openFilterDialog,
        child: Icon(Icons.add),
      ),
      body: selectedUserList == null || selectedUserList!.length == 0
          ? Center(child: Text('No user selected'))
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedUserList![index].name!),
                );
              },
              itemCount: selectedUserList!.length,
            ),
    );
  }
```


## How to use `FilterListWidget`.
```dart

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key, this.selectedUserList})
      : super(key: key);
  final List<User>? selectedUserList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilterListWidget<User>(
        listData: userList,
        selectedListData: selectedUserList,
        onApplyButtonClick: (list) {
          // do something with list ..
        },
        choiceChipLabel: (item) {
          /// Used to display text on chip
          return item!.name;
        },
        validateSelectedItem: (list, val) {
          ///  identify if item is selected or not
          return list!.contains(val);
        },
        onItemSearch: (user, query) {
          /// When search query change in search bar then this method will be called
          ///
          /// Check if items contains query
          return user.name!.toLowerCase().contains(query.toLowerCase());
        },
      ),
    );
  }
}
```

## How to use `FilterListDelegate`.
Create a function and call `FilterListDelegate.open()` on button tap.

``` dart
 void openFilterDelegate() async {
   await FilterListDelegate.open<User>(
      context: context,
      list: userList,
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      tileLabel: (user) => user!.name,
      emptySearchChild: Center(child: Text('No user found')),
      searchFieldHint: 'Search Here..',
      onApplyButtonClick: (list) {
        // Do something with selected list
      },
    );
  }
```

## Screenshots


Empty screen |  FilterListDialog        |  Selected chip           |  Result from dialog
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/1.jpeg" width="300">| <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/2.jpeg" width="300"> | <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/3.jpeg" width="300"> | <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/4.jpeg" width="300">

### Customized Dialog  Header
  |  |   |  |
:-------------------------:|:-------------------------:|:-------------------------:|
<img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/6.jpeg" width="300">| <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/7.jpeg" width="300"> | <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/8.jpeg" width="300"> | 

### Customized Choice chip
|  |  |   |  |
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/9.jpg" width="300">| <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/10.jpeg" width="300"> | <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/11.jpg" width="300"> | <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/12.jpeg" width="300">


 ### FilterListWidget
|  Default| Customized |  customized  |
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/screenshots/13.jpeg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/screenshots/15.jpeg?raw=true)|![](https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/16.jpeg)|

### FilterListDelegate
| Single selection | Multiple selection  |Multiple selection
|:-:|:-:|:-:|
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/screenshots/17.jpeg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/screenshots/18.jpeg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/screenshots/19.jpeg?raw=true)|


| Search through list  | Customized Tile  |
|:-:|:-:|
<img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/20.jpeg" width="300"> </img>| </a> <img src="https://raw.githubusercontent.com/TheAlphamerc/flutter_plugin_filter_list/screenshots/21.jpeg" width="300"></img></a>




## Parameters

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| height | `double` | Set height of filter dialog.|
| width  | `double` | Set width of filter dialog.|
| hideCloseIcon|`bool`|Hide close Icon.|
| hideHeader|`bool`|Hide complete header section from filter dialog.|
| headerCloseIcon|`Widget`|Widget to close the dialog.|
| hideSelectedTextCount|`bool`|Hide selected text count.|
| hideSearchField|`bool`|Hide search text field.|
| headlineText|`String`|Set header text of filter dialog.|
| backgroundColor|`Color`|Set background color of filter color|
| listData|`List<T>()`|Populate filter dialog with text list. |
| selectedListData|` List<T>()`|Marked selected text in filter dialog.|
| choiceChipLabel|`String Function(T item)`| Display text on choice chip.|
| validateSelectedItem|`bool Function(List<T>? list, T item)`| Identifies weather a item is selected or not|
| onItemSearch|`List<T> Function(List<T>? list, String text)`| Perform search operation and returns filtered list|
| choiceChipBuilder|`Widget Function(BuildContext context, T? item, bool? isSelected)`|The choiceChipBuilder is a builder to design custom choice chip.|
| onApplyButtonClick|`Function(List<T> list)`|Returns list of items when apply button is clicked|
| validateRemoveItem|`List<T> Function(List<T>? list, T item)`| Function Delegate responsible for delete item from list |
| resetButtonText|`String`| Reset button text to customize or translate |
| allButtonText|`String`| All button text to customize or translate |
| selectedItemsText|`String`| Selected items text to customize or translate |
| controlButtons|`List<ControlButtonType>`| configure which control button needs to be display on bottom of dialog along with 'Apply' button.|
| insetPadding| `EdgeInsets`| The amount of padding added to the outside of the dialog.|
| themeData|`FilterListThemeData`| Configure theme of filter dialog and widget.|
| choiceChipTheme|`ChoiceChipThemeData`| Configure theme of choice chip.|
| controlButtonBarTheme|`ControlButtonBarThemeData`| Configure theme of control button bar|
| controlButtonTheme|`ControlButtonThemeData`| Configure theme of control button.|
| headerTheme|`HeaderThemeData`| Configure theme of filter header.|


> `T` can be a String or any user defined Model 
  

## Other Flutter packages
 Name        | Stars        | Pub |
:-------------------------|------------------------- | ------------------------- |
|[Empty widget](https://github.com/TheAlphamerc/empty_widget) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/empty_widget?style=social)](https://github.com/login?return_to=https://github.com/TheAlphamerc/empty_widget) | [![pub package](https://img.shields.io/pub/v/empty_widget?color=blue)](https://pub.dev/packages/empty_widget) |
|[Add Thumbnail](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_add_thumbnail?style=social)](https://github.com/login?return_to=https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail) | [![pub package](https://img.shields.io/pub/v/add_thumbnail?color=blue)](https://pub.dev/packages/add_thumbnail) |
|[Country Provider](https://github.com/TheAlphamerc/country_provider) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/country_provider?style=social)](https://github.com/login?return_to=https://github.com/TheAlphamerc/country_provider) | [![pub package](https://img.shields.io/pub/v/country_provider?color=blue)](https://pub.dev/packages/country_provider) |


## Pull Requests

I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.

## Created & Maintained By

[Sonu Sharma](https://github.com/TheAlphamerc) ([Twitter](https://www.twitter.com/TheAlphamerc)) ([Youtube](https://www.youtube.com/user/sonusharma045sonu/))
([Insta](https://www.instagram.com/_sonu_sharma__))  ![Twitter Follow](https://img.shields.io/twitter/follow/thealphamerc?style=social)

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>

> * <a href="https://www.buymeacoffee.com/thealphamerc"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" width="200"></a>
> * [PayPal](https://www.paypal.me/TheAlphamerc/)


## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/flutter_plugin_filter_list/count.svg" alt ="Loading">


