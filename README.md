
## empty_Widget  [![pub package](https://img.shields.io/pub/v/filter_list?color=blue)](https://pub.dev/packages/filter_list) [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_filter_list?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_plugin_filter_list)![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/flutter_plugin_filter_list?style=social) ![GitHub last commit](https://img.shields.io/github/last-commit/Thealphamerc/flutter_plugin_filter_list) [![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/Thealphamerc/flutter_plugin_filter_list)


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
    "Ten"
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
              headlineText: "Select Countries",
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
```


## Download App ![GitHub All Releases](https://img.shields.io/github/downloads/Thealphamerc/flutter_plugin_filter_list/total?color=green)
<a href="https://github.com/TheAlphamerc/flutter_plugin_filter_list/releases/download/v0.0.1/app-release.apk"><img src="https://playerzon.com/asset/download.png" width="200"></img></a>

## Screenshots


Screenshot             |  Screenshot
:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_2.jpg?raw=true)|
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_3.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_4.jpg?raw=true)|



## Pull Requests

I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.

## Created & Maintained By

[Sonu Sharma](https://github.com/TheAlphamerc) ([Twitter](https://www.twitter.com/TheAlphamerc)) ([Youtube](https://www.youtube.com/user/sonusharma045sonu/))
([Insta](https://www.instagram.com/_sonu_sharma__))  ![Twitter Follow](https://img.shields.io/twitter/follow/thealphamerc?style=social)

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>
> * [PayPal](https://www.paypal.me/TheAlphamerc/)




