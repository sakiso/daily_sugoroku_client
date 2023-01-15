import 'package:daily_sugoroku_client/models/plan_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/plan_repository.dart';

final plansOfDayProvider =
    StateNotifierProvider<PlansOfDayNotifier, List<Plan>>((ref) {
  return PlansOfDayNotifier(ref);
});

class PlansOfDayNotifier extends StateNotifier<List<Plan>> {
  Ref ref;
  PlansOfDayNotifier(this.ref) : super([]);

  void fetchPlans() async {
    state = await PlanRepository.fetchPlans(ref);

    for (final plan in state) {
      print(plan.toMap());
    }
  }

  void removePlan(int id) async {
    // todo: まだcommitしてなくてid振られてないplanがなぜ消せる？
    final numberOfRowsDeleted = await PlanRepository.deletePlan(ref, id: id);
    print('numberOfRowsDeleted: $numberOfRowsDeleted');
    if (numberOfRowsDeleted == 0) return; // 何も削除されなかった場合

    /// note: stateはimutableなのでリストを再生成する必要がある
    state = [
      for (final plan in state)
        if (plan.id != id) plan,
    ];
  }

  void editPlanName(String newPlanName, Plan targetPlan) {
    print('edit!');
    print('newPlan: ${targetPlan.hashCode}');

    for (final plan in state) {
      print('olgPlan: ${plan.name}');
    }

    /// stateの特定のindexの要素を置換する。ここでは永続化は実施しない
    // todo: updateとごっちゃになる もっといい名前ないかな

    state = [
      for (final orginalPlan in state)
        if (targetPlan.hashCode == orginalPlan.hashCode)
          targetPlan.copyWith(name: newPlanName)
        else
          orginalPlan
    ];
    for (final plan in state) {
      print('newPlan: ${plan.name}');
    }

    // state = [
    //   for (var i = 0; i < state.length; i++)
    //     (targetIndexOfState == i) ? newPlan : state[i]
    // ];
  }

  void addBlankPlan() async {
    state = [
      ...state,
      Plan(
        scheduledAt: DateTime.now(),
      ),
    ];
  }

  void updatePlans(List<Plan> plans) async {
    await PlanRepository.savePlans(ref, plans);
  }
}
