import XCTest

@testable import Bolota

class MultimapTests: XCTestCase {

    var multimap: Multimap<Int, Int> = Multimap()

    override func setUp() {
        multimap = Multimap()
    }

    func testRetriveItemFromEmptyMultimap() {
        XCTAssert(multimap.get(0) == [])
    }

    func testAddAndRetrieveItemFromMultimap() {
        multimap.put(key: 0, value: 0)
        XCTAssert(multimap.get(0) == [0])
    }

    func testAddAndRetrieveMultipleItemsFromMultimap() {
        multimap.put(key: 0, value: 0)
        multimap.put(key: 0, value: 1)
        XCTAssert(multimap.get(0) == [0, 1])
    }

    func testAddAndRetrieveItemFromMultimapUsingSubscriptNotation() {
        multimap.put(key: 0, value: 0)
        XCTAssert(multimap[0] == [0])
    }

    func testAddAndRetrieveMultipleItemsFromMultimapUsingSubscriptNotation() {
        multimap.put(key: 0, value: 0)
        multimap.put(key: 0, value: 1)
        XCTAssert(multimap[0] == [0, 1])
    }

    func testIterateThroughMultimap() {
        multimap.put(key: 0, value: 0)
        multimap.put(key: 1, value: 1)

        let iterator = multimap.makeIterator()

        XCTAssert(iterator.next()! == (0, [0]))
        XCTAssert(iterator.next()! == (1, [1]))
        XCTAssert(iterator.next() == nil)
    }

    func testEncodeMultimapAsJSONString() {
        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]

        multimap.put(key: 0, value: 0)
        multimap.put(key: 0, value: 1)
        multimap.put(key: 1, value: 2)
        multimap.put(key: 1, value: 3)

        let data = try? encoder.encode(multimap)

        if let data = data {
            let jsonString = String(data: data, encoding: .utf8)

            XCTAssert(jsonString == "{\"0\":[0,1],\"1\":[2,3]}")
        } else {
            XCTFail()
        }
    }
}
