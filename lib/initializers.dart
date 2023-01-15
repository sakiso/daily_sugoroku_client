import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';

/// アプリ起動時に一度だけ行いたいような初期化処理はここに記載する
initializeDB() async {
  print("DB初期化");

  final migrationScripts = {
    /// ここにMigration内容を追記していく。
    /// verが増えたらSetting(Constants)のDBverも更新すること
    '2': ['ALTER TABLE ${TableNames.plans} ADD scheduledAt TEXT;'],
  };

  await openDatabase(
    join(await getDatabasesPath(), 'daily_sugoroku.db'),
    onCreate: (db, version) {
      return db.execute(
        // note: migrationするときは同じテーブルになるようここも更新すること
        '''
        CREATE TABLE IF NOT EXISTS 
        ${TableNames.plans}(
          id INTEGER PRIMARY KEY,
          name TEXT, 
          requiredMinutes INTEGER,
          scheduledAt TEXT);
        PRAGMA foreign_keys = ON;
        ''',
      );
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      var batch = db.batch();
      for (var i = oldVersion + 1; i <= newVersion; i++) {
        var queries = migrationScripts[i.toString()];
        for (String query in queries!) {
          batch.execute(query);
        }
      }
    },
    version: Settings.currentDBversion,
  );
}