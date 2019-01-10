//
//  ExTypeTests.swift
//  ExTypeTests
//
//  Created by 王渊鸥 on 2019/1/5.
//  Copyright © 2019 WangYuanOu. All rights reserved.
//

import XCTest
import ExType



class ExTypeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIntNearUp() {
        XCTAssertEqual(45, Int(nearUp: 44.2))
        XCTAssertEqual(45, Int(nearUp: 45))
        XCTAssertEqual(45, Int(nearUp: 44.8))
    }
    
    func testIntConvert() {
        XCTAssertNil(Int("34A"))
        XCTAssertEqual(34, Int(skipLetter: "34A"))
    }
    
    func testIntDescription() {
        XCTAssertEqual("4千", 4000.chineseDescription)
        XCTAssertEqual("4千", 4100.chineseDescription)
        XCTAssertEqual("4.1万", 41000.chineseDescription)
        XCTAssertEqual("4万", 40000.chineseDescription)
        XCTAssertEqual("4.1亿", 410000000.chineseDescription)
        XCTAssertEqual("4亿", 400000000.chineseDescription)
    }
    
    func testLimit() {
        XCTAssertEqual(45, 78.limited(20, 45))
        XCTAssertEqual(20, 10.limited(20, 45))
    }
    
    func testExSet() {
        XCTAssertEqual(100, setup(100, { print($0) }))
    }
    
    func testMod() {
        XCTAssert((25.6 % 25.5) ~ 0.1, "not nearly equal")
    }

    func testUUID() {
        XCTAssertNotEqual(UUID(), UUID())
    }
    
    func testArrayRemove() {
        let list = [1,5,6,10,2,2,7,22,12,6,22,1,4]
        XCTAssertEqual([1,5,10,2,2,7,22,12,6,22,1,4], try! list.removed(at: 2))
        XCTAssertEqual([5,10,2,2, 22,12,6,22,1,4], try! list.removed(at: [0, 2, 6]))
        XCTAssertEqual([1,5,10,7,22,12,22,1,4], list.removed(in: [0,2,6]))
        XCTAssertEqual([6,2,2,6], list.removed(notIn: [0,2,6]))
    }
    
    func testJson() {
        let dict:[String: Any] = [
            "num": 12,
            "str": "aaaaaaa",
            "arr": [1,2,3],
            "sub": [
                "num":13,
                "str":"bbbbbb"
                ]
        ]
        let text = """
            {
                "num":12,
                "str":"aaaaaaa",
                "sub":{
                    "num":13,
                    "str":"bbbbbb"
                },
                "arr":[1,2,3]
            }
        """
        XCTAssertEqual(dict.jsonString!, text.jsonDictionary!.jsonString!)
    }
    
    func testMd5() {
        XCTAssertEqual("7f9d3ecc3d3d93f35d2dc972298d6862".uppercased(), "Abd3231".md5)
    }
    
    func testBase64() {
        XCTAssertEqual("QWJkMzIzMQ==", "Abd3231".base64Encoded!)
        XCTAssertEqual("Abd3231", "QWJkMzIzMQ==".base64Decoded!)
    }
    
    func testRegex() {
        let result = ["1234", "hello", "world"]
        XCTAssertEqual(result, "([0-9]+)([a-z]+)\\.([a-z]+)".regex(text: "1234hello.world"))
        XCTAssertTrue("([0-9]+)([a-z]+)\\.([a-z]+)".isMatch(text: "1234hello.world"))
        XCTAssertFalse("([0-9]+)([a-z]+)\\.([a-z]+)".isMatch(text: "1234_hello.world"))
        XCTAssertEqual("hello world -> 1234", "([0-9]+)([a-z]+)\\.([a-z]+)".regexOutput(source:"1234hello.world", templete:"$2 $3 -> $1"))
    }
    
    func testTrim() {
        let text = "   ab cd efg    =   "
        XCTAssertEqual("ab cd efg    =", text.trimed)
        XCTAssertEqual("ab cd efg", text.trim(characters: " ="))
        XCTAssertEqual("ab cd efg    =   ", text.trimLeft(characters: " ="))
        XCTAssertEqual("   ab cd efg", text.trimRight(characters: " ="))
    }
    
    func testIndex() {
        XCTAssertEqual(5, "abcdefg".index(at: 5)!.encodedOffset)
        XCTAssertNil("abcdefg".index(at: 8))
    }
    
    func testSubscript() {
        let text = "abcdefghijklmn"
        XCTAssertEqual("defghij", text[3..<10])
        XCTAssertEqual("defghij", text[3...9])
        XCTAssertEqual("abcdefghij", text[..<10])
        XCTAssertEqual("efghijklmn", text[4...])
        XCTAssertEqual("d", text[3])
    }
    
    func testSplit() {
        let text = "   ab cd efg    =   "
        XCTAssertEqual(["ab", "cd", "efg", "="], text.split(" ", limit: 5))
        XCTAssertEqual(["ab", "cd", "efg    =   "], text.split(" ", limit: 3))
    }
    
    func testSubString() {
        let text = "abcdefghijklmn"
        XCTAssertEqual("defghij", text.subString(from: 3, size: 7))
        XCTAssertNil(text.subString(from: 100, size: 100))
    }
    
    func testFix() {
        let text = "123"
        XCTAssertEqual("00123", text.fixFront(fix: "0", textLength: 5))
        XCTAssertEqual("123000", text.fixBack(fix: "0", textLength: 6))
    }
    
    func testFormat(){
        let text = "=ABCDEFG="
        XCTAssertTrue(text.isFormat(start: "=", middle: "ABCDEFGHIJKLMN", end: "="))
        XCTAssertFalse(text.isFormat(start: nil, middle: "ABCD", end: nil))
    }
    
    func testCount() {
        let text = "abcdadbcaasdasdf"
        XCTAssertEqual(5, text.count("a"))
        XCTAssertEqual(9, text.count(check: { "abc".contains($0) }))
    }
    
    func testStringRemove() {
        let text = "abcdadbcaasdasdf"
        XCTAssertEqual("abcddbcaasdasdf", text.removed(at: 4))
        XCTAssertEqual("abcddbasdasdf", try! text.removed(at: [4, 7, 9]))
    }
    
    func testPercent() {
        XCTAssertEqual(0.5, 4.6 % 4.1)
        XCTAssertTrue(0.5 ~ 0.50000001)
        XCTAssertFalse(0.5 ~ 0.51)
    }
    
    func testFixedPath() {
        let homePath = String.homePath
        XCTAssertEqual(homePath.appendPath("Documents"), String.documentsPath)
        XCTAssertEqual(homePath.appendPath("Library"), String.libraryPath)
    }
    
    func testExistsPath() {
        let homePath = String.homePath
        XCTAssertTrue(homePath.existsDirectory)
        XCTAssertFalse(homePath.existsFile)
    }
    
    func testCreateDir() {
        let homePath = String.homePath.appendPath("hello")
        try! homePath.createDirectory()
        XCTAssertTrue(homePath.existsDirectory)
        
        try! homePath.removePath()
        XCTAssertFalse(homePath.existsDirectory)
    }
    
    func testComponents() {
        let path = "/Test/Test2/Test3/Test4.test5.test"
        XCTAssertEqual(["/", "Test","Test2","Test3","Test4.test5.test"], path.pathComponents)
        XCTAssertEqual("test", path.pathExtension)
        XCTAssertEqual("Test4.test5.test", path.lastPathComponent)
        XCTAssertEqual("Test4.test5", path.lastPathMainbody)
    }
    
    func testUIType() {
        XCTAssertEqual(UIFont.systemFont(ofSize: 20).text, UIFont(text: UIFont.systemFont(ofSize: 20).text)!.text)
        XCTAssertEqual("20.0%30.0%40.0%50.0", CGRect(x: 20, y: 30, width: 40, height: 50).text)
        XCTAssertEqual(CGRect(x: 20, y: 30, width: 40, height: 50), CGRect(text: "20%30%40%50"))
        XCTAssertEqual("20.0%30.0", CGPoint(x: 20, y: 30).text)
        XCTAssertEqual(CGPoint(x: 20, y: 30), CGPoint(text: "20%30"))
        XCTAssertEqual("40.0%50.0", CGSize(width: 40, height: 50).text)
        XCTAssertEqual(CGSize(width: 40, height: 50), CGSize(text: "40%50"))
        let trans = CGAffineTransform(translationX: 20, y: 20).rotated(by: CGFloat(2*Double.pi)).text
        XCTAssertEqual(trans, CGAffineTransform(text: trans)!.text)
    }
    
    func testISODate() {
        let date = Date()
        XCTAssertEqual(date.ISOString, Date(ISOString: date.ISOString)!.ISOString)
    }
    
    func testIntHex() {
        XCTAssertEqual(0xf4, Int(hex:"f4"))
    }
    
    func testCollectionValues() {
        XCTAssertEqual(20, [10,20,30].value(at: 1))
        XCTAssertNil([10,20,30].value(at: 3))
        XCTAssertNil([10,20,30].value(at: -1))
        XCTAssertTrue((1, 2) == [1,2,3,4,5,6,7,8,9].tuple2!)
        XCTAssertTrue((1, 2, 3) == [1,2,3,4,5,6,7,8,9].tuple3!)
        XCTAssertTrue((1, 2, 3, 4) == [1,2,3,4,5,6,7,8,9].tuple4!)
        XCTAssertTrue((1, 2, 3, 4, 5) == [1,2,3,4,5,6,7,8,9].tuple5!)
        XCTAssertTrue((1, 2, 3, 4, 5, 6) == [1,2,3,4,5,6,7,8,9].tuple6!)
        XCTAssertNil([1,2,3,4].tuple6)
    }
    
    func testMapDict() {
        XCTAssertEqual(["1":1, "2":2, "3":3], [1,2,3].map(toDict: { (String($0), $0) }))
    }
    
    func testSkipIndex() {
        let list = [1,2,1,2,3,4,3,4,1,2,3,4,1,2,3,4]
        XCTAssertEqual(3, list.firstIndex(skip: 1, where: { $0 == 2 }))
        XCTAssertEqual(9, list.firstIndex(skip: 2, where: { $0 == 2 }))
        XCTAssertEqual(13, list.lastIndex(skip: 0, where: { $0 == 2 }))
        XCTAssertEqual(9, list.lastIndex(skip: 1, where: { $0 == 2 }))
    }
    
    func testGroup() {
        let list = [1,2,1,2,3,4,3,4,1,2,3,4,1,2,3,4]
        XCTAssertEqual([[1,1,1,1], [2,2,2,2], [3,3,3,3], [4,4,4,4]], list.group())
        XCTAssertFalse(list.areSerial(<))
        XCTAssertTrue([1,3,5,6,7].areSerial(<))
        XCTAssertTrue([8,6,2,1].areSerial(>))
        XCTAssertFalse(list.areEqual)
        XCTAssertTrue([1,1,1,1].areEqual)
    }
    
    func testForEach() {
        let list = [1,2,1,2,3,4,3,4,1,2,3,4,1,2,3,4]
        var amountList:[Int] = []
        list.forEach(score: { (item) in
            amountList.append(item.amount)
        })
        XCTAssertEqual([1,3,4,6,9,13,16,20,21,23,26,30,31,33,36,40], amountList)
        XCTAssertTrue([NearItem(nil,1,2), NearItem(1,2,3), NearItem(2,3,4), NearItem(3,4,nil)] == [1,2,3,4].nearList)
        var result:[Int?] = []
        [1,2,3,4].forEach(near: {
            result.append($0.prev)
        })
        XCTAssertEqual([nil, 1, 2, 3], result)
    }
    
    func testSearch() {
        let list = [1,2,1,2,3,4,3,4,1,2,3,4,1,2,3,4]
        XCTAssertEqual(4, list.first(skip:1, where: { $0 > 2 }))
        XCTAssertEqual(1, list.last(skip: 1, where: { $0 < 3 }))
    }
    
    func testArrayCount() {
        let list = [1,2,1,2,3,4,3,4,1,2,3,4,1,2,3,4]
        XCTAssertEqual(4, list.count(check: { $0 == 2 }))
    }
    
    func testContains() {
        let list = [1,2,1,2,3,4,3,4,1,2,3,4,1,2,3,4]
        XCTAssertTrue(list.containsAll(in: [1,2,3,4]))
        XCTAssertFalse(list.containsAll(in: [1,2,3,4,5]))
    }
    
    func testURL() {
        XCTAssertEqual("http://www.test.com", URL(auto: "http://www.test.com")!.absoluteString)
        XCTAssertEqual("file:///Test/Test", URL(auto: "/Test/Test")!.absoluteString)
    }
}
