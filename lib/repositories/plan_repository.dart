import 'package:daily_sugoroku_client/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../models/plan_model.dart';
import '../providers/sqflite_database_provider.dart';

class PlanRepository {
  // todo: リポジトリはDomainServiceのInterFaceを参照するようにする？
  Future<List<PlanModel>> fetchPlans(WidgetRef ref) async {
    final database = await ref.watch(databaseProvider) as Database;

    final plans = await database
        .query(TableNames.plans, where: 'name = ?', whereArgs: ['hoge']);
    // todo: ListじゃなくてPlanModelを返すようにする
    print(plans);
    return plans.map((plan) => PlanModel.fromMap(plan)).toList();
  }

  Future<int> savePlans(WidgetRef ref) async {
    //todo: upsertに対応する
    final database = await ref.watch(databaseProvider) as Database;

    final record = PlanModel(name: "hoge", requiredMinutes: 15);
    final savedId = await database.insert(TableNames.plans, record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return savedId;
  }
}
