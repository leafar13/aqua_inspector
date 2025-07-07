import 'package:aqua_inspector/features/samples/domain/entities/sample_item.dart';

class SampleItemModel extends SampleItem {
  const SampleItemModel({
    required super.id,
    required super.samplingDatetime,
    required super.sampleNumber,
    required super.waterAssociationName,
    required super.systemName,
    required super.isSynced,
  });

  factory SampleItemModel.fromJson(Map<String, dynamic> json) {
    return SampleItemModel(
      id: json['id'] as int,
      samplingDatetime: DateTime.parse(json['samplingDatetime'] as String),
      sampleNumber: json['sampleNumber'] as String,
      waterAssociationName: json['waterAssociationName'] as String,
      systemName: json['systemName'] as String,
      isSynced: json['isSynced'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'samplingDatetime': samplingDatetime.toIso8601String(),
      'sampleNumber': sampleNumber,
      'waterAssociationName': waterAssociationName,
      'systemName': systemName,
      'isSynced': isSynced,
    };
  }

  SampleItem toEntity() {
    return SampleItem(
      id: id,
      samplingDatetime: samplingDatetime,
      sampleNumber: sampleNumber,
      waterAssociationName: waterAssociationName,
      systemName: systemName,
      isSynced: isSynced,
    );
  }
}