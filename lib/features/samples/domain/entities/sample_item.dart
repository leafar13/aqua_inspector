// Entidad de dominio para items de lista de muestras
class SampleItem {
  final int id;
  final DateTime samplingDatetime;
  final String sampleNumber;
  final String waterAssociationName;
  final String systemName;
  final bool isSynced;

  const SampleItem({
    required this.id,
    required this.samplingDatetime,
    required this.sampleNumber,
    required this.waterAssociationName,
    required this.systemName,
    required this.isSynced,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SampleItem &&
        other.id == id &&
        other.samplingDatetime == samplingDatetime &&
        other.sampleNumber == sampleNumber &&
        other.waterAssociationName == waterAssociationName &&
        other.systemName == systemName &&
        other.isSynced == isSynced;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        samplingDatetime.hashCode ^
        sampleNumber.hashCode ^
        waterAssociationName.hashCode ^
        systemName.hashCode ^
        isSynced.hashCode;
  }

  @override
  String toString() {
    return 'SampleItem(id: $id, samplingDatetime: $samplingDatetime, sampleNumber: $sampleNumber, waterAssociationName: $waterAssociationName, systemName: $systemName, isSynced: $isSynced)';
  }
}