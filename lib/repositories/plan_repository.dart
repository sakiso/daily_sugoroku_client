import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../models/plan_model.dart';
import '../providers/sqflite_database_provider.dart';

class PlanRepository {
  // todo: リポジトリはDomainServiceのInterFaceを参照する？
  Future<PlanModel> fetchPlans(WidgetRef ref) async {
    // todo: DBのplansテーブルに接続する処理が別途必要？
    final database = await ref.watch(databaseProvider);

    final record = PlanModel(name: "hoge", requiredMinutes: 15);
    await database.insert("plans", record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    final plan =
        await database.query('plans', where: 'name = ?', whereArgs: ['hoge']);
    // todo: ListじゃなくてPlanModelを返すようにする
    print(plan);
    return plan.fromMap();
  }
}
