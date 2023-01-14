import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// アプリ起動時に一度だけ行いたいような初期化処理はここに記載する
initializeDB() async {
  print("DB初期化");

  await openDatabase(
    join(await getDatabasesPath(), 'daily_sugoroku.db'),
    onCreate: (db, version) {
      return db.execute(
        '''
        CREATE TABLE IF NOT EXISTS 
        plans(id INTEGER PRIMARY KEY, name TEXT, requiredMinutes INTEGER);
        PRAGMA foreign_keys = ON;
        ''',
      );
    },
    version: 1,
  );
}
