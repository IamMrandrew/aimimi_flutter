class GoalModel {
  String name;
  String period;
  String days;
  String amount;

  GoalModel(this.name, this.period, this.days, this.amount);
}

List<GoalModel> goals = goalData
    .map((item) =>
        GoalModel(item['name'], item['photo'], item['days'], item['amount']))
    .toList();

final goalData = [
  {"name": "Drink Water", "period": "Everyday", "days": "30", "amount": "0"},
  {"name": "Push Up", "period": "Everyday", "days": "21", "amount": "4"},
  {"name": "Pull Up", "period": "Everyday", "days": "21", "amount": "8"}
];
