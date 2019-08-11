import 'package:dart/models/labels.dart';
import 'package:dart/widgets/settings_group.dart';
import 'package:dart/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Legends extends StatelessWidget {
  const Legends();

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      items: Labels.all.map((tag) => SettingsItem(
            label: tag.name,
            icon: tag.icon,
          )).toList(),
    );
  }
}
