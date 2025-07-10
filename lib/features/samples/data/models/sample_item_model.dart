import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/sample_item.dart';

part 'sample_item_model.freezed.dart';
part 'sample_item_model.g.dart';

@freezed
abstract class SampleItemModel with _$SampleItemModel {
  const factory SampleItemModel({
    required int id,
    required DateTime samplingDatetime,
    required String sampleNumber,
    required String waterAssociationName,
    required String systemName,
    @Default(false) bool isSynced,
  }) = _SampleItemModel;

  factory SampleItemModel.fromJson(Map<String, dynamic> json) => _$SampleItemModelFromJson(json);

  // Método para convertir a entidad de dominio (si aún la necesitas)
  const SampleItemModel._();
  SampleItem toEntity() => SampleItem(
    id: id,
    samplingDatetime: samplingDatetime,
    sampleNumber: sampleNumber,
    waterAssociationName: waterAssociationName,
    systemName: systemName,
    isSynced: isSynced,
  );
}
