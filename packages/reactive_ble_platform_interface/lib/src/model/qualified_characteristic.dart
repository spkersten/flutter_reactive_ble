import 'package:meta/meta.dart';

import 'uuid.dart';

/// Specific BLE characteristic for a BLE device characterised by [deviceId], [serviceId] and
/// [characteristicId].
@immutable
class QualifiedCharacteristic {
  /// Unique uuid of the specific characteristic
  final Uuid characteristicId;

  final String? index;

  /// Service uuid of the characteristic
  final Uuid serviceId;

  final String? serviceIndex;

  /// Device id of the BLE device
  final String deviceId;

  const QualifiedCharacteristic({
    required this.characteristicId,
    required this.serviceId,
    required this.deviceId,
    this.index,
    this.serviceIndex,
  });

  @override
  String toString() =>
      "$runtimeType(characteristicId: $characteristicId, index: $index, "
      "serviceId: $serviceId, serviceIndex: $serviceIndex, deviceId: $deviceId)";

  @override
  int get hashCode =>
      Object.hash(characteristicId, index, serviceId, serviceIndex, deviceId);

  @override
  bool operator ==(Object other) =>
      other is QualifiedCharacteristic &&
      runtimeType == other.runtimeType &&
      characteristicId == other.characteristicId &&
      index == other.index &&
      serviceId == other.serviceId &&
      serviceIndex == other.serviceIndex &&
      deviceId == other.deviceId;
}
