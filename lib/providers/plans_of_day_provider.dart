import 'package:daily_sugoroku_client/models/plan_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/plan_repository.dart';

final plansProvider =
    StateNotifierProvider<PlansNotifier, List<PlanModel>>((ref) {
  return PlansNotifier(ref);
});

class PlansNotifier extends StateNotifier<List<PlanModel>> {
  Ref ref;
  // 空のリストとして初期化
  PlansNotifier(this.ref) : super([]);

  fetchPlans() async {
    state = await PlanRepository.fetchPlans(ref);
    // fixme: これ無限に走ってる
    print('state: $state');
  }

  addPlans() {
    // todo: addplans実装予定
    //     PlanRepository.savePlans(
    //   ref,
    //   name: "dummy",
    //   requiredMinutes: 35,
    //   scheduledAt: DateTime.now(),
    // );
  }
}
