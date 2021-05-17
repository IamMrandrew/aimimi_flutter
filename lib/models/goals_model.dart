class GoalModel {
  String category;
  String description;
  int frequency;
  String period;
  bool publicity;
  int timespan;
  String title;

  // GoalModel(this.category, this.description, this.frequency, this.period,
  //     this.publicity, this.timespan, this.title);
  GoalModel(this.category, this.description, this.frequency, this.period,
      this.publicity, this.timespan, this.title);
}

// List<GoalModel> goals = goalData
//     .map((item) => GoalModel(
//         item['goals'],
//         item['category'],
//         item['description'],
//         item['frequency'],
//         item['period'],
//         item['publicity'],
//         item['timespan'],
//         item['title']))
//     .toList();

// final goalData = [
//   {
//     "category": "Lifestyle",
//     "description": "This is the first goal",
//     "frequency": 3,
//     "period": "Daily",
//     "publicity": false,
//     "timespan": 30,
//     "title": "AAA goal"
//   },
// ];
