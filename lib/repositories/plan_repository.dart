import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PlanRepository {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<List> fetchPlans() async {
    // todo: ListじゃなくてPlanModelを返すようにする

    print("read");
    print(await storage.read(key: 'token'));

    await storage.write(key: 'token', value: 'ABCsDE');
    print("write ABsCDE");

    String? token = await storage.read(key: 'token');
    return [token];
  }
}
