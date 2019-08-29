import 'package:dart/config_loader.dart';
import 'package:dart/screens/settings/settings_api.dart';
import 'package:dart/widgets/legends.dart';
import 'package:dart/widgets/settings_group.dart';
import 'package:dart/widgets/settings_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildShowSampleSetting(BuildContext context) {
    return SettingsItem(
      label: 'Load samples',
      icon: Icon(CupertinoIcons.collections_solid),
      content: CupertinoSwitch(
        value: ConfigLoader().config.showExamples,
        onChanged: (value) async {
          ConfigLoader().config.showExamples = value;
          await ConfigLoader().save();
          setState(() {});
        },
      ),
    );
  }

  Widget _buildApiSetting(BuildContext context) {
    return SettingsItem(
      label: 'API',
      icon: Icon(CupertinoIcons.padlock),
      content: SettingsNavigationIndicator(),
      onPress: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (BuildContext context) {
          return ApiSettingsPage();
        }));
      },
    );
  }

  Widget _buildHighPerformanceSetting(BuildContext context) {
    return SettingsItem(
      label: 'Performance Over Graphics',
      icon: Icon(Icons.high_quality),
      content: CupertinoSwitch(
        value: ConfigLoader().config.higherPerformance,
        onChanged: (value) async {
          ConfigLoader().config.higherPerformance = value;
          await ConfigLoader().save();
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        color: Color(0xfff0f0f0),
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Settings'),
            ),
            SliverSafeArea(
                sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                SettingsGroup(
                  items: <SettingsItem>[
                    _buildShowSampleSetting(context),
                    _buildHighPerformanceSetting(context),
                    _buildApiSetting(context),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10.0),),
                const Legends(),
              ]),
            )),
          ],
        ),
      ),
    );
  }
}
