import 'dart:io';

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

    // sqfliteがDATETIMEに対応していないので、TEXTからDataTimeに変換する
    final convertedPlans = plans.map((plan) {
      return {
        ...plan,
        'scheduledAt': DateTime.parse(plan['scheduledAt'] as String),
      };
    }).toList();

    return convertedPlans.map((plan) => Plan.fromMap(plan)).toList();
  }

  static Future<List<Object?>> savePlans(Ref ref, List<Plan> plans) async {
    //todo: nullチェックして必須項目が埋まってなければ更新しない。migrateもする
    final database = await ref.watch(databaseProvider) as Database;

    final records = plans.map((plan) => plan.toMap()).toList();
    for (var record in records) {
      // sqfliteがDATETIMEに対応していないので、TEXTに変換してから記録する
      // todo: 検索のこと考えたらdatetimeじゃなくてYYYYMMDD(string)にしたほうが良いのでする。。。
      record['scheduledAt'] = record['scheduledAt'].toIso8601String();
    }

    final batch = database.batch();
    for (var record in records) {
      batch.insert(
        TableNames.plans,
        record,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    final results = await batch.commit();
    print('results');
    print(results);
    return results;
  }

  static Future<int> deletePlan(
    Ref ref, {
    required int id,
  }) async {
    //todo: upsertに対応する
    final database = await ref.read(databaseProvider) as Database;

    final numberOfRowsDeleted = await database.delete(
      TableNames.plans,
      where: 'id = $id',
    );
    return numberOfRowsDeleted;
  }
}
