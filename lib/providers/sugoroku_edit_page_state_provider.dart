import 'package:daily_sugoroku_client/providers/plans_of_day_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final existIncompletePlanProvider = StateProvider<bool>((ref) {
  final plans = ref.watch(plansOfDayProvider);

  // todayPlansの中にnameまたはrequiredMinutesが未設定のplanがあるかどうか
  final incompletePlans =
      plans.where((plan) => plan.name == null || plan.requiredMinutes == null);
  return incompletePlans.isNotEmpty;
});
