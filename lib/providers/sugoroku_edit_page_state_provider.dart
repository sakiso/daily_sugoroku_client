import 'package:daily_sugoroku_client/providers/plans_of_day_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/plan_model.dart';

// todayPlansの中にnameまたはrequiredMinutesが未設定のplanがあるかどうか
final existIncompletePlanProvider = StateProvider<bool>((ref) {
  final plans = ref.watch(plansOfDayProvider);
  final incompletePlans =
      plans.where((plan) => plan.name == null || plan.requiredMinutes == null);
  return incompletePlans.isNotEmpty;
});
