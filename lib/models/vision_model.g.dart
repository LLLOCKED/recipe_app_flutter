// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

ObjectData _$ObjectDataFromJson(Map<String, dynamic> json) => ObjectData(
      name: json['name'] as String,
      similarity: json['similarity'] as int,
      coordinates:
          Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ObjectDataToJson(ObjectData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'similarity': instance.similarity,
      'coordinates': instance.coordinates,
    };

Vision _$VisionFromJson(Map<String, dynamic> json) => Vision(
      objectData: (json['objectData'] as List<dynamic>)
          .map((e) => ObjectData.fromJson(e as Map<String, dynamic>))
          .toList(),
      labelsObjects: (json['labelsObjects'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      uniqueNames: (json['uniqueNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$VisionToJson(Vision instance) => <String, dynamic>{
      'objectData': instance.objectData,
      'uniqueNames': instance.uniqueNames,
      'labelsObjects': instance.labelsObjects,
    };
