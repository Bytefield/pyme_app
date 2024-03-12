import 'package:flutter/material.dart';
import 'package:pyme_app/src/sample_feature/sample_item.dart';
import 'package:realm/realm.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final Realm realm = Realm(Configuration.local([SampleItem.schema]));
  final items = realm.all<SampleItem>();

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(
    MyApp(
      settingsController: settingsController,
      items: items,
      realm: realm,
    ),
  );
}
