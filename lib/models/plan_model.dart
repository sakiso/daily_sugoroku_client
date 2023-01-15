import '../utilities/format_minutes_to_hhmm.dart';

class PlanModel {
  int? id;
  //todo: IDの採番はDomainServiceでやらす。永続化したときに確定する感じで
  //todo: modelってクラス名じゃないほうが良いかも 例を調べる
  String name = "";
  int requiredMinutes = 0;
  DateTime scheduledAt;

  PlanModel({
    required this.name,
    required this.requiredMinutes,
    required this.scheduledAt,
    this.id,
  });

  static PlanModel fromMap(Map map) {
    final id = map['id'];
    final name = map['name'];
    final requiredMinutes = map['requiredMinutes'];
    final scheduledAt = map['scheduledAt'];

    return PlanModel(
      id: id,
      name: name,
      requiredMinutes: requiredMinutes,
      scheduledAt: scheduledAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'requiredMinutes': requiredMinutes,
      'scheduledAt': scheduledAt,
    };
  }

  String formattedRequiredMinutes() {
    // 例: input 135 -> output "02:15"
    //     input 0   -> output "--:--"
    if (requiredMinutes == 0) return "--:--";
    return formatMinutesToHHMM(requiredMinutes);
  }
}
