import 'package:daily_sugoroku_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/plan_model.dart';
import '../../providers/plans_of_day_provider.dart';
import 'components/time_picker.dart';

class SugorokuEditPage extends ConsumerStatefulWidget {
  const SugorokuEditPage({Key? key}) : super(key: key);

  @override
  SugorokuEditPageState createState() => SugorokuEditPageState();
}

class SugorokuEditPageState extends ConsumerState<SugorokuEditPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(plansProvider.notifier).fetchPlans();
  }

  @override
  Widget build(BuildContext context) {
    List<Plan> todayPlans = ref.watch(plansProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("編集画面"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(children: [
            for (final plan in todayPlans)
              Row(
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () => {_removePlan(plan.id!)},
                    color: ConstantColors.cautionRed,
                    icon: const Icon(Icons.delete),
                  ),
                  Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 50.0,
                        child: TextFormField(
                          initialValue: plan.name,
                          textAlignVertical: TextAlignVertical.center,
                          onFieldSubmitted: (newPlanName) {
                            plan.name = newPlanName;
                            _updatePlan(plan);
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                // 上下のpaddingを付けると見切れが発生するため明示的にゼロ指定
                                const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            hintText: '予定名を入力してください',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: ConstantColors.darkGray,
                                width: 2.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: ConstantColors.royalBlue,
                                width: 4.0,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ConstantColors.inactiveGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        // todo: 時間が設定されたらフォントカラーや背景色をいい感じの色にする
                        child: Text(plan.formattedRequiredMinutes()),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return const TimePicker();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    // todo: これボタンじゃなくてフォーカスアウトとかで保存するか
                    iconSize: 30,
                    onPressed: () => {_updatePlan(plan)},
                    color: ConstantColors.lightBlue,
                    icon: const Icon(Icons.add_circle_outlined),
                  ),
                ],
                // todo: このへんにプラスボタンでフォーム増やせるようにする。forで回す数を増やす感じ？
              ),
            TextButton(
              child: const Text("戻る"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
        ),
      ),
    );
  }

  void _removePlan(int id) {
    ref.read(plansProvider.notifier).removePlan(id);
  }

  void _updatePlan(Plan plan) {
    ref.read(plansProvider.notifier).updatePlan(plan);
  }
}
