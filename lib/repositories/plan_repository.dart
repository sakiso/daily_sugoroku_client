import 'package:daily_sugoroku_client/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../models/plan_model.dart';
import '../providers/sqflite_database_provider.dart';

class PlanRepository {
  // todo: リポジトリはDomainServiceのInterFaceを参照するようにする？
  Future<List<PlanModel>> fetchPlans(WidgetRef ref) async {
    final database = await ref.watch(databaseProvider) as Database;

    List<Map<String, Object?>> plans = await database.query(
      TableNames.plans,
      where: 'name = ?',
      whereArgs: ['hoge'],
    );

    // todo: 2回実行するとUnsupported operation: read-onlyといわれる

    // sqfliteがDATETIMEに対応していないので、TEXTからDataTimeに変換する
    final mappedPlans = plans.map((plan) {
      return {
        ...plan,
        'scheduledAt': DateTime.parse(plan['scheduledAt'] as String),
      };
    }).toList();
    var convertedPlans = mappedPlans.toList();

    print(convertedPlans);
    return convertedPlans.map((plan) => PlanModel.fromMap(plan)).toList();
  }

  Future<int> savePlans(WidgetRef ref) async {
    //todo: upsertに対応する
    final database = await ref.watch(databaseProvider) as Database;

    final record = PlanModel(
      name: "hoge",
      requiredMinutes: 15,
      scheduledAt: DateTime.now(),
    );

    // sqfliteがDATETIMEに対応していないので、TEXTに変換してから記録する
    final mappedRecord = record.toMap();
    mappedRecord['scheduledAt'] = record.scheduledAt.toIso8601String();

    final savedId = await database.insert(
      TableNames.plans,
      mappedRecord,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return savedId;
  }
}
