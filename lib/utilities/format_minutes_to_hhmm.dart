String formatMinutesToHHMM(int minutes) {
  // 例: input 135 -> output "02:15"
  final hoursString = (minutes / 60).floor().toString().padLeft(2, "0");
  final minutesString = (minutes % 60).toString().padLeft(2, "0");
  return "$hoursString:$minutesString";
}
