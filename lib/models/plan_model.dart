class PlanModel {
  int? id; //todo: IDの採番はDomainServiceでやらす。永続化したときに確定する感じで
  String name = "";
  int requiredMinutes = 0;

  PlanModel({required this.name, required this.requiredMinutes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'requiredMinutes': requiredMinutes,
    };
  }

  PlanModel fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    requiredMinutes = map['requiredMinutes'];
    return this;
  }
}
