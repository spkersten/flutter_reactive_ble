import class CoreBluetooth.CBUUID
import class CoreBluetooth.CBCharacteristic

struct QualifiedCharacteristic: Equatable {

    let id: CharacteristicID
    let index: Int
    
    let serviceID: ServiceID
    let serviceIndex: Int
    
    let peripheralID: PeripheralID
}

extension QualifiedCharacteristic {

    init(_ characteristic: CBCharacteristic) {
        let service = characteristic.service!
        let peripheral = service.peripheral
        
        let index = service.characteristics?.filter({ c in c.uuid == characteristic.uuid }).firstIndex(of: characteristic)
        let serviceIndex = peripheral?.services?.filter({ s in s.uuid == service.uuid }).firstIndex(of: service)
        
        self.init(
            id: characteristic.uuid,
            index: index!,
            serviceID: characteristic.service?.uuid ?? ServiceID(),
            serviceIndex: serviceIndex!,
            peripheralID: characteristic.service?.peripheral?.identifier ?? PeripheralID(uuid: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
        )
    }
}

struct QualifiedCharacteristicIDFactory {

    func make(from message: CharacteristicAddress) -> QualifiedCharacteristic? {
        guard
            message.hasCharacteristicUuid,
            message.hasServiceUuid,
            let peripheralID = UUID(uuidString: message.deviceID)
        else { return nil }

        let characteristicID = CBUUID(data: message.characteristicUuid.data)
        let serviceID = CBUUID(data: message.serviceUuid.data)
        let index = Int(message.characteristicIndex)
        let serviceIndex = Int(message.serviceIndex)

        return QualifiedCharacteristic(
            id: characteristicID,
            index: index ?? 0,
            serviceID: serviceID,
            serviceIndex: serviceIndex ?? 0,
            peripheralID: peripheralID
        )
    }
}
