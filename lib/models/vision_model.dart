import 'package:json_annotation/json_annotation.dart';

part 'vision_model.g.dart';

@JsonSerializable()
class Coordinates {
  final double x;
  final double y;

  Coordinates({required this.x, required this.y});

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}

@JsonSerializable()
class ObjectData {
  final String name;
  final int similarity;
  final Coordinates coordinates;

  ObjectData(
      {required this.name,
      required this.similarity,
      required this.coordinates});

  factory ObjectData.fromJson(Map<String, dynamic> json) =>
      _$ObjectDataFromJson(json);
  Map<String, dynamic> toJson() => _$ObjectDataToJson(this);
}

@JsonSerializable()
class Vision {
  final List<ObjectData> objectData;
  final List<String> uniqueNames;
  final List<String> labelsObjects;

  Vision(
      {required this.objectData,
      required this.labelsObjects,
      required this.uniqueNames});

  factory Vision.fromJson(Map<String, dynamic> json) => _$VisionFromJson(json);
  Map<String, dynamic> toJson() => _$VisionToJson(this);
}
