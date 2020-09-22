
## filter_list Plugin 
[![pub package](https://img.shields.io/pub/v/filter_list?color=blue)](https://pub.dev/packages/filter_list)  [![Codemagic build status](https://api.codemagic.io/apps/5e5f9812018eb900168eef48/5e5f9812018eb900168eef47/status_badge.svg)](https://codemagic.io/apps/5e5f9812018eb900168eef48/5e5f9812018eb900168eef47/latest_build) ![GitHub last commit](https://img.shields.io/github/last-commit/Thealphamerc/flutter_plugin_filter_list) [![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/Thealphamerc/flutter_plugin_filter_list) ![GitHub](https://img.shields.io/github/license/TheAlphamerc/flutter_plugin_filter_list) [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_filter_list?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_plugin_filter_list) ![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/flutter_plugin_filter_list?style=social)


FilterList is a flutter plugin which is designed to provide ease in filter data from list of strings.

## Download App ![GitHub All Releases](https://img.shields.io/github/downloads/Thealphamerc/flutter_plugin_filter_list/total?color=green)
<a href="https://github.com/TheAlphamerc/flutter_plugin_filter_list/releases/download/v0.0.5/app-release.apk"><img src="https://playerzon.com/asset/download.png" width="200"></img></a>

## Data flow 
* Pass list of strings to `FilterList.showFilterList()`.
* Pass list of selected strings to show pre-selected text otherwise ignore it.
* Invoke method `FilterList.showFilterList()` to display filter dialog.
* Make selection from list.
* Click `All` button to select all text from list.
* Click `Reset` button to make all text unselected.
* Click `Apply` buton to return selected list of strings.
* On `close` icon clicked it close dialog and return null value.
* Without making any selection `Apply` button is pressed it will return empty list of string.

## Getting Started
### 1. Add library to your pubspec.yaml



```yaml

dependencies:
  filter_list: ^0.0.5

```

### 2. Import library in dart file

```dart
import package:filter_list/filter_list.dart';
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
#### Create a function and call `FilterListDialog.display()` on button clicked
```dart
  void _openFilterDialog() async {
    await FilterListDialog.display(
      context,
      allTextList: countList,
      height: 480,
      borderRadius: 20,
      headlineText: "Select Count",
      searchFieldHintText: "Search Here",
      selectedTextList: selectedCountList,
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            selectedCountList = List.from(list);
          });
        }
        Navigator.pop(context);
      });
  }
```
#### Call `_openFilterDialog` function on `floatingActionButton` pressed to display filter dialog

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openFilterDialog,
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
#### To display filter widget use `FilterListWidget` and pass list of strings to it.

```dart
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
            if(list != null){
              print("selected list length: ${list.length}");
            }
          },
        ),
      ),
    );
  }
}
```
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


FilterListWidget |N/A |N/A |N/A
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
<img src="https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_14.jpg?raw=true" width="200"></img>|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_101.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_121.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_111.jpg?raw=true)|



### Parameters and Value

 `height` Type: **double**
* Set height of filter dialog.

`width` Type: **double**
* Set width of filter dialog.

`borderRadius` Type: **double**
* Set border radius of filter dialog.

`allTextList` Type: **List\<String>()**
* Populate filter dialog with text list.

`selectedTextList` Type: **List\<String>()**
* Marked selected text in filter dialog.

`headlineText` Type: **String**
* Set header text of filter dialog.

`searchFieldHintText` Type: **String**
* Set hint text in search field.

`hideSelectedTextCount` Type: **bool**
* Hide selected text count.

 `hideSearchField` Type: **bool**
* Hide search text field.

`hidecloseIcon` Type: **bool**
* Hide close Icon.

`hideheader` Type: **bool**
* Hide complete header section from filter dialog.

`closeIconColor` Type: **Color**
* set color of close Icon.

`headerTextColor` Type: **Color**
* Set color of header text.

`applyButonTextColor` Type: **Color**
* Set text color of apply button.

 `applyButonTextBackgroundColor` Type: **Color**
* Set background color of apply button.

`allResetButonColor` Type: **Color**
* Set text color of all and reset button.

`selectedTextColor` Type: **Color**
* Set color of selected text in filter dialog.

`selectedTextBackgroundColor` Type: **Color**
* Set background color of selected text field.

`unselectedTextbackGroundColor` Type: **Color**
* Set background color of unselected text field.

`unselectedTextColor` Type: **Color**
* Set text color of unselected text in filter dialog

`searchFieldBackgroundColor` Type: **Color**
* Set background color of Search field.

`backgroundColor` Type: **Color**
* Set background color of filter color.

`onApplyButtonClick` Type **Function(List<String>)**
 * Returns list of strings when apply button is clicked 

## Flutter plugins
Plugin Name        | Stars        
:-------------------------|-------------------------
|[Empty widget](https://github.com/TheAlphamerc/empty_widget) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/empty_widget?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%empty_widget)
|[Add Thumbnail](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_add_thumbnail?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_plugin_add_thumbnail)


## Pull Requests

I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.

## Created & Maintained By

[Sonu Sharma](https://github.com/TheAlphamerc) ([Twitter](https://www.twitter.com/TheAlphamerc)) ([Youtube](https://www.youtube.com/user/sonusharma045sonu/))
([Insta](https://www.instagram.com/_sonu_sharma__))  ![Twitter Follow](https://img.shields.io/twitter/follow/thealphamerc?style=social)

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>
> * [PayPal](https://www.paypal.me/TheAlphamerc/)




