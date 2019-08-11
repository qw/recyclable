import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'config_loader.dart';
import 'screens/prediction_page.dart';
import 'screens/settings/settings_page.dart';

void main() async {
  await ConfigLoader().load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Recyclable',
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,

      ),
      home: MyHomePage(title: 'Recyclable Home'),
      debugShowCheckedModeBanner: false,
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
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        if (index == 1) {
          return SettingsPage();
        } else {
          return PredictionPage();
        }
      },
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
