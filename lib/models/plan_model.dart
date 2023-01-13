class PlanModel {
  int? id; //todo: IDの採番はDomainServiceでやらす。永続化したときに確定する感じで
  String name = "";
  int requiredMinutes = 0;

  PlanModel(this.name, this.requiredMinutes);
}
