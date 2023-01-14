import '../models/plan_model.dart';

class PlanRepository {
  // todo: リポジトリはDomainServiceのInterFaceを参照する？
  Future<PlanModel> fetchPlans() async {
    // todo: ListじゃなくてPlanModelを返すようにする
    PlanModel plan = PlanModel(name: "hoge", requiredMinutes: 10);
    return plan;
  }
}
