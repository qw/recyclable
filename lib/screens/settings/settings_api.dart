import 'package:dart/widgets/textfield_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../config_loader.dart';

class ApiSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ApiSettingsPageState();
}

class _ApiSettingsPageState extends State<ApiSettingsPage> {
  TextEditingController _apiEndpointController = TextEditingController();
  TextEditingController _apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _apiEndpointController.text = ConfigLoader().config.apiEndpoint;
    _apiKeyController.text = ConfigLoader().config.apiKey;

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Settings',
        middle: Text('API Settings'),
      ),
      child: SafeArea(
        child: Container(
          color: Color(0xfff0f0f0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              TextFieldSetting(
                _apiEndpointController,
                title: 'API Endpoint',
                action: CupertinoButton(
                  child: Text('Save'),
                  onPressed: () {
                    ConfigLoader().config.apiEndpoint = _apiEndpointController.text;
                    ConfigLoader().save();
                    setState(() {

                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              TextFieldSetting(
                _apiKeyController,
                title: 'API Key',
                action: CupertinoButton(
                  child: Text('Save'),
                  onPressed: () {
                    ConfigLoader().config.apiKey = _apiKeyController.text;
                    ConfigLoader().save();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                constraints: BoxConstraints(
                    minWidth: double.infinity, maxWidth: double.infinity),
                child: CupertinoButton(
                  child: Text('Reset'.toUpperCase()),
                  color: Colors.red,
                  onPressed: () {
                    print(ConfigLoader().defaultConfig.apiKey);
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Confirmation'),
                            content: Text(
                                'Are you sure you want to reset API settings?'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text('No'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              CupertinoDialogAction(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  ConfigLoader().config.apiKey =
                                      ConfigLoader().defaultConfig.apiKey;
                                  ConfigLoader().config.apiEndpoint =
                                      ConfigLoader().defaultConfig.apiEndpoint;
                                  ConfigLoader().save();
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
