import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

final Provider databaseProvider = Provider(
  (ref) async {
    return await openDatabase(
        join(await getDatabasesPath(), 'daily_sugoroku.db'),
        version: Settings.currentDBversion);
  },
);
