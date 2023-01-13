import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PlanRepository {
  // todo: リポジトリはDomainServiceのInterFaceを参照する？
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<List> fetchPlans() async {
    // todo: ListじゃなくてPlanModelを返すようにする

    await storage.write(key: 'token', value: 'ABCsDE');

    String? token = await storage.read(key: 'token');
    return [token];
  }
}
