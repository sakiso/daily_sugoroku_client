import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final Provider databaseProvider = Provider(
  (ref) async {
    return await openDatabase(
      join(await getDatabasesPath(), 'daily_sugoroku.db'),
    );
  },
);
