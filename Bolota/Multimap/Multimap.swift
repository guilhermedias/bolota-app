import Foundation

class Multimap<KeyType: Hashable & Comparable & Encodable, ValueType: Encodable> {
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

extension Multimap: Sequence {
    func makeIterator() -> AnyIterator<(KeyType, [ValueType])> {
        var iterator = dictionary.keys
            .sorted()
            .makeIterator()

        return AnyIterator {
            if let key = iterator.next() {
                return (key, self.dictionary[key]!)
            }

            return nil
        }
    }
}

extension Multimap: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(dictionary)
    }
}
