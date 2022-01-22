class ReceipeModel {
  String? appLabel;
  String? imageUrl;
  double? calories;
  String? appUrl;
  ReceipeModel({this.appLabel, this.imageUrl, this.calories, this.appUrl});
  factory ReceipeModel.factoryforMap(Map element) {
    double calories = element['recipe']['calories'];
    double preciseCalories = double.parse(calories.toStringAsFixed(2));
    return ReceipeModel(
      appLabel: element['recipe']['label'],
      imageUrl: element['recipe']['image'],
      calories: preciseCalories,
      appUrl: element['recipe']['url'],
    );
  }
}
