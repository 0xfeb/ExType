# ExType
### Easy library for types extra usage. 

### Install

* Use source code, download source and drag into your project. 

* Use cocoapods, write a line into your Podfile. 
`pod 'ExType'`


### Builder
* Extension -- Int

Initial from string type
> `init(string: String)`


Initial from hex string
> `init(hex: String)`

* Extension -- Float

Initial from string type
> `init(string: String)`

* Extension -- Double

Initial from string type
> `init(string: String)`

### Helper
* Extension -- Int

Chinese string description, use '亿,万,千' characters
> `var chineseDescription: String`

* Extension -- Comparable

Set a value between min and max numbers. It will be reset as min value while it less than the min number, or set as max value in the opsite situation
> `func limit(min: Self, max: Self)`

* Extension -- Range

Initial from bounds numbers, about include or exclude the bounds.
> `init(incStart: Bound, incEnd: Bound)`

> `init(incStart: Bound, excEnd: Bound)`

> `init(excStart: Bound, incEnd: Bound)`

> `init(excStart: Bound, excEnd: Bound)`

* Function

Setup an object in a block of code. 
> `func ex_set<T>(_ item: T, _ action: (T) -> Void) -> T`

For example: 

``` language=swift
let view = ex_set(UIView()){ 
    $0.backgroundColor = UIColor.red
    $0.frame = CGRect(x:0, y:0, width:100, height:100)
}
```

### MD5
This is a source code copy from website

All rights of this file belong Paul Johnston

You can find the origin code in http://pajhome.org.uk/crypt/md5


### Random

* Function

Get a random number between lower and upper numbers.
> `func ex_random<T: FixedWidthInteger>(lower: T = T.min, upper: T = T.max) -> T`

### Array

* Extension -- Array

Get a optional value at index of array. The number of subscript of array is not optional, It will rise a exception if the value is not exists. In this function, use optional result to replace the exception.
> `func value(at index: Int) -> Element?`

Get a random list in a array. It will get all values in array if the parametor "count" less the the count number of array.
> `func randomList(count: Int) -> [Element]`

Build a dictionary by an array.
> `func buildDictionary<Key, Value>(toDict combiner: (Element) -> (Key, Value)) -> [Key: Value]`

* Function

Get an array by stride. Unlike stride function in swift foundition library, this stride function can divide number to parts. 
> `func ex_stride(from: Double, to toValue: Double, numberOfParts: Double) -> [Double]`

> `func ex_stride(from: Int, to toValue: Int, numberOfParts: Int) -> [Int]`

### Dictionary

* Extension -- Dictionary

Convert current dictionary to another one like map function.
> `func map<K, V>(_ converter: (Key, Value) -> (K, V)?) -> [K: V]`

Get a json string of dictionary.
> `var json: String?`

* Function

Convert a json string to dictionary.
> `func ex_json(text: String) -> [String: Any]?`


### String

* Extension -- String

Get md5 string of current string
> `var md5: String`

Get base64 encoded string of current string
> `var base64Encoded: String?`

Get base64 decoded string of current string
> `var base64Decoded: String?`

Current string as regular expression to parse a text and get mathced result.
> `func regexMatch(text: String) -> [String]?`

Property - Get trimed string, remove whitespace character in begin or end of string.
> `var trimed : String`

Get index of offset

> `func index(of offset: Int) -> String.Index`

Get sub string by integer range

> `subscript(_ range: Range<Int>) -> String`

* Function

Generate an UUID String
> `func ex_uuid() -> String`


### FilePath

* Class - ExFilePath

Property - full string of path
> `var fullPath: String`

Initial by full string of path
> `init(_ fullPath: String)`

Initial by url of path
> `init?(_ url: URL)`

Enumlate of path type

```
enum PathType {
    case file
    case directory
}
```

Property - path type
> `var pathType: PathType`

List subpath of current path, use recurison to deep list.
> `func listSubPaths(recurison: Bool = false) -> [ExFilePath]`

Create a dictionary
> `static func createPath(path: String) -> Bool`

Remove a dictionary or file
> `static func removePath(path: String) -> Bool`

Home dictionary of this application
> `static var home: ExFilePath`

Documents dictionary of this application
> `static var documents: ExFilePath`

Library dictionary of this application
> `static var library: ExFilePath`

Bundle dictionary of this application
> `static var bundle: ExFilePath`

List path components
> `var pathComponents: [String]`

Get path extension
> `var pathExtension: String`

Get last component of path
> `var lastPathComponent: String`

Get last main body of path, eg. /AA/BB/CC.txt, the last main body of path is CC
> `var lastPathMainbody: String`

Add component at the end of path.
> `func addComponent(string: String)`

> `func addComponented(string: String) -> String`

* Function

Generate url by string.
> `func ex_url(_ string: String) -> URL?`

### Author
WangYuanou

2018-07-26

