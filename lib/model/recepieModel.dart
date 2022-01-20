class ReceipeModel {
  String? appLabel;
  String? imageUrl;
  double? calories;
  String? appUrl;
  ReceipeModel({this.appLabel, this.imageUrl, this.calories, this.appUrl});
  factory ReceipeModel.factoryforMap(Map element) {
    return ReceipeModel(
      appLabel: element['recipe']['label'],
      imageUrl: element['recipe']['image'],
      calories: element['recipe']['calories'],
      appUrl: element['recipe']['url'],
    );
  }
}
