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
}
