import 'package:daily_sugoroku_client/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../models/plan_model.dart';
import '../providers/sqflite_database_provider.dart';

class PlanRepository {
  // todo: リポジトリはDomainServiceのInterFaceを参照するようにする？
  Future<List<PlanModel>> fetchPlans(
    WidgetRef ref, {
    DateTime? scheduledAt,
  }) async {
    final database = await ref.watch(databaseProvider) as Database;

    String query = "";
    if (scheduledAt != null) {
      query = ' AND scheduledAt = ${scheduledAt.toIso8601String()}';
    }

    List<Map<String, Object?>> plans = await database.query(
      TableNames.plans,
      where: query,
      whereArgs: ['hoge'],
    );

    // sqfliteがDATETIMEに対応していないので、TEXTからDataTimeに変換する
    final convertedPlans = plans.map((plan) {
      return {
        ...plan,
        'scheduledAt': DateTime.parse(plan['scheduledAt'] as String),
      };
    }).toList();

    print(convertedPlans);
    return convertedPlans.map((plan) => PlanModel.fromMap(plan)).toList();
  }

  Future<int> savePlans(
    WidgetRef ref, {
    required String name,
    required int requiredMinutes,
    required DateTime scheduledAt,
  }) async {
    //todo: upsertに対応する
    final database = await ref.watch(databaseProvider) as Database;

    final record = PlanModel(
      name: name,
      requiredMinutes: requiredMinutes,
      scheduledAt: scheduledAt,
    );

    // sqfliteがDATETIMEに対応していないので、TEXTに変換してから記録する
    final mappedRecord = record.toMap();
    mappedRecord['scheduledAt'] = record.scheduledAt.toIso8601String();

    final savedId = await database.insert(
      TableNames.plans,
      mappedRecord,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(savedId);
    return savedId;
  }
}
