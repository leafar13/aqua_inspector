// Entidad de dominio para items de lista de muestras
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_item.freezed.dart';
part 'sample_item.g.dart';

@freezed
abstract class SampleItem with _$SampleItem {
  const factory SampleItem({
    required int id,
    required DateTime samplingDatetime,
    required String sampleNumber,
    required String waterAssociationName,
    required String systemName,
    @Default(false) bool isSynced,
  }) = _SampleItem;

  factory SampleItem.fromJson(Map<String, dynamic> json) => _$SampleItemFromJson(json);
}
