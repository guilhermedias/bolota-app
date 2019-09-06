import Foundation

class Multimap<KeyType: Hashable, ValueType> {
    private var dictionary: Dictionary<KeyType, [ValueType]>

    init() {
        dictionary = Dictionary()
    }

    subscript(key: KeyType) -> [ValueType] {
        get {
            return retrieveValues(forKey: key)
        }
    }

    func get(_ key: KeyType) -> [ValueType] {
        return retrieveValues(forKey: key)
    }

    func put(key: KeyType, value: ValueType) {
        if let values = dictionary[key] {
            dictionary[key] = values + [value]
        } else {
            dictionary[key] = [value]
        }
    }

    private func retrieveValues(forKey key: KeyType) -> [ValueType] {
        if let values = dictionary[key] {
            return values
        } else {
            return []
        }
    }
}
