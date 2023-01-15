import 'package:daily_sugoroku_client/models/plan_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/plan_repository.dart';

final plansProvider = StateNotifierProvider<PlansNotifier, List<Plan>>((ref) {
  return PlansNotifier(ref);
});

class PlansNotifier extends StateNotifier<List<Plan>> {
  Ref ref;
  // 空のリストとして初期化
  PlansNotifier(this.ref) : super([]);

  void fetchPlans() async {
    state = await PlanRepository.fetchPlans(ref);
  }

  void removePlan(int id) {
    /// note: stateはimutableなのでリストを再生成する必要がある
    state = [
      for (final plan in state)
        if (plan.id != id) plan,
    ];
  }

  void addPlan() {
    // todo: addplan実装予定
    //     PlanRepository.savePlans(
    //   ref,
    //   name: "dummy",
    //   requiredMinutes: 35,
    //   scheduledAt: DateTime.now(),
    // );
  }
}
