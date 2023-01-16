import '../utilities/format_minutes_to_hhmm.dart';

class Plan {
  int? id;
  //todo: IDの採番はDomainServiceでやらす。永続化したときに確定する感じで
  String? name = "";
  int? requiredMinutes = 0;
  String scheduledAtDate; // yyyyMMdd形式

  Plan({
    this.name,
    this.requiredMinutes,
    required this.scheduledAtDate,
    this.id,
  });

  static Plan fromMap(Map map) {
    final id = map['id'];
    final name = map['name'];
    final requiredMinutes = map['requiredMinutes'];
    final scheduledAtDate = map['scheduledAt'];

    return Plan(
      id: id,
      name: name,
      requiredMinutes: requiredMinutes,
      scheduledAtDate: scheduledAtDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'requiredMinutes': requiredMinutes,
      'scheduledAt': scheduledAtDate,
    };
  }

  String formattedRequiredMinutes() {
    // 例: input 135 -> output "02:15"
    //     input 0   -> output "--:--"
    if (requiredMinutes == 0 || requiredMinutes == null) return "--:--";
    return formatMinutesToHHMM(requiredMinutes!);
  }

  // note: RiverpodのStateは更新できないため複製する必要がある
  Plan copyWith({
    int? id,
    String? name,
    int? requiredMinutes,
    DateTime? scheduledAt,
  }) {
    return Plan(
      id: id ?? this.id,
      name: name ?? this.name,
      requiredMinutes: requiredMinutes ?? this.requiredMinutes,
      scheduledAtDate: scheduledAtDate,
    );
  }
}
