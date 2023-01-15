import 'package:daily_sugoroku_client/models/plan_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/plan_repository.dart';

final plansProvider = StateNotifierProvider<PlansNotifier, List<Plan>>((ref) {
  return PlansNotifier(ref);
});

class PlansNotifier extends StateNotifier<List<Plan>> {
  Ref ref;
  PlansNotifier(this.ref) : super([]);

  void fetchPlans() async {
    state = await PlanRepository.fetchPlans(ref);
  }

  void removePlan(int id) async {
    final numberOfRowsDeleted = await PlanRepository.deletePlan(ref, id: id);
    if (numberOfRowsDeleted == 0) return; // 何も削除されなかった場合

    /// note: stateはimutableなのでリストを再生成する必要がある
    state = [
      for (final plan in state)
        if (plan.id != id) plan,
    ];
  }

  void addPlan(Plan plan) async {
    await PlanRepository.savePlan(ref, plan);
    // todo: addplan実装予定
    //     PlanRepository.savePlans(
    //   ref,
    //   name: "dummy",
    //   requiredMinutes: 35,
    //   scheduledAt: DateTime.now(),
    // );
  }

  void updatePlan(Plan plan) async {
    await PlanRepository.savePlan(ref, plan);
  }
}
