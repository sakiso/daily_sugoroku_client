import 'package:daily_sugoroku_client/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../models/plan_model.dart';
import '../providers/sqflite_database_provider.dart';

class PlanRepository {
  // todo: リポジトリはDomainServiceのInterFaceを参照するようにする？
  static Future<List<Plan>> fetchPlans(
    Ref ref, {
    DateTime? scheduledAt,
  }) async {
    final database = await ref.watch(databaseProvider) as Database;

    String? query;
    if (scheduledAt != null) {
      query = 'scheduledAt = ${scheduledAt.toIso8601String()}';
    }

    List<Map<String, Object?>> plans = await database.query(
      TableNames.plans,
      where: query,
    );

    return plans.map((plan) => Plan.fromMap(plan)).toList();
  }

  static Future<List<Object?>> savePlans(Ref ref, List<Plan> plans) async {
    final database = await ref.watch(databaseProvider) as Database;

    final records = plans.map((plan) => plan.toMap()).toList();

    final batch = database.batch();
    for (var record in records) {
      batch.insert(
        TableNames.plans,
        record,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    final results = await batch.commit();
    return results;
  }

  static Future<int> deletePlan(
    Ref ref, {
    required int id,
  }) async {
    final database = await ref.read(databaseProvider) as Database;

    final numberOfRowsDeleted = await database.delete(
      TableNames.plans,
      where: 'id = $id',
    );
    return numberOfRowsDeleted;
  }
}
