import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final String type;
  final String? id;
  final String? title;
  final String? message;
  final String? topic;
  final Map<String, dynamic>? additionalData;

  NotificationModel({
    required this.type,
    this.id,
    this.title,
    this.message,
    this.topic,
    this.additionalData,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
