class PlanModel {
  int? id; //todo: IDの採番はDomainServiceでやらす。永続化したときに確定する感じで
  String name = "";
  int requiredMinutes = 0;

  PlanModel({required this.name, required this.requiredMinutes, this.id});

  static PlanModel fromMap(Map map) {
    final id = map['id'];
    final name = map['name'];
    final requiredMinutes = map['requiredMinutes'];

    return PlanModel(
      id: id,
      name: name,
      requiredMinutes: requiredMinutes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'requiredMinutes': requiredMinutes,
    };
  }
}
