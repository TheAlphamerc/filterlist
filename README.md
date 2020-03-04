
## empty_Widget 
[![pub package](https://img.shields.io/pub/v/filter_list?color=blue)](https://pub.dev/packages/filter_list)  [![Codemagic build status](https://api.codemagic.io/apps/5e5f9812018eb900168eef48/5e5f9812018eb900168eef47/status_badge.svg)](https://codemagic.io/apps/5e5f9812018eb900168eef48/5e5f9812018eb900168eef47/latest_build) ![GitHub last commit](https://img.shields.io/github/last-commit/Thealphamerc/flutter_plugin_filter_list) [![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/Thealphamerc/flutter_plugin_filter_list) ![GitHub](https://img.shields.io/github/license/TheAlphamerc/flutter_plugin_filter_list) [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_filter_list?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_plugin_filter_list) ![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/flutter_plugin_filter_list?style=social)


FilterList is a flutter plugin which is designed to provide ease in filter data from list of strings.


## Getting Started
### 1. Add library to your pubspec.yaml



```yaml

dependencies:
  filter_list: ^0.0.1

```

### 2. Import library in dart file

```dart
import 'import 'package:filter_list/filter_list.dart';';
```


### 3. How to use FilterList


#### Create a list of Strings
```dart
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
```
#### Create a function and call `FilterList.showFilterList()` dialog on button clicked
```dart
  void _openFilterList() async {
    var list = await FilterList.showFilterList(
      context,
      allTextList: countList,
      height: 450,
      borderRadius: 20,
      headlineText: "Select Count",
      searchFieldHintText: "Search Here",
      selectedTextList: selectedCountList,
    );
    
    if (list != null) {
      setState(() {
        selectedCountList = List.from(list);
      });
    }
  }
```
#### Call `_openFilterList` function on `floatingActionButton` pressed

```dart
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
        /// check for empty or null value selctedCountList
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
```


## Download App ![GitHub All Releases](https://img.shields.io/github/downloads/Thealphamerc/flutter_plugin_filter_list/total?color=green)
<a href="https://github.com/TheAlphamerc/flutter_plugin_filter_list/releases/download/v0.0.1/app-release.apk"><img src="https://playerzon.com/asset/download.png" width="200"></img></a>

## Screenshots


No selected text from list |  FilterList widget        |  Make selection           |  Selected text from list
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_3.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_4.jpg?raw=true)|

Hidden close Icon    |  Hidden text field     |  Hidden header text    |  Hidden full header
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_5.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_6.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_7.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_8.jpg?raw=true)|

Customised control button |Customised selected text |Customised unselected text  |Customised text field background color
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_9.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_10.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_12.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_11.jpg?raw=true)|




### Parameters and Value

#####  `height`
* Set height of filter dialog.

##### `width`
* Set width of filter dialog.

##### `borderRadius`
* Set border radius of filter dialog.

#### `allTextList`
* Populate filter dialog with text list.

#### `selectedTextList`
* Marked selected text in filter dialog.

##### `headlineText`
* Set header text of filter dialog.

##### `searchFieldHintText`
* Set hint text in search field.

#### `hideSelectedTextCount`
* Hide selected text count.

##### `hideSearchField`
* Hide search text field.

##### `hidecloseIcon`
* Hide close Icon.

#####  `hideheader`
* Hide complete header section from filter dialog.

##### `closeIconColor`
* set color of close Icon.

##### `headerTextColor`
* Set color of header text.

#### `applyButonTextColor`
* Set text color of apply button.

#### `applyButonTextBackgroundColor`
* Set background color of apply button.

##### `allResetButonColor`
* Set text color of all and reset button.

##### `selectedTextColor`
* Set color of selected text in filter dialog.

##### `selectedTextBackgroundColor`
* Set background color of selected text field.

##### `unselectedTextbackGroundColor`
* Set background color of unselected text field.

#### `unselectedTextColor`
* Set text color of unselected text in filter dialog

##### `searchFieldBackgroundColor`
* Set background color of Search field.

#### `backgroundColor`
* Set background color of filter color.





## Pull Requests

I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.

## Created & Maintained By

[Sonu Sharma](https://github.com/TheAlphamerc) ([Twitter](https://www.twitter.com/TheAlphamerc)) ([Youtube](https://www.youtube.com/user/sonusharma045sonu/))
([Insta](https://www.instagram.com/_sonu_sharma__))  ![Twitter Follow](https://img.shields.io/twitter/follow/thealphamerc?style=social)

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>
> * [PayPal](https://www.paypal.me/TheAlphamerc/)




