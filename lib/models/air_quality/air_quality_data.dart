import 'package:json_annotation/json_annotation.dart';

part 'air_quality_data.g.dart';

@JsonSerializable()
class AirQualityData {
  final double latitude;
  final double longitude;

  AirQualityData({
    required this.latitude,
    required this.longitude,
  });

  factory AirQualityData.fromJson(Map<String, dynamic> json) => _$AirQualityDataFromJson(json);

  Map<String, dynamic> toJson() => _$AirQualityDataToJson(this);
}
