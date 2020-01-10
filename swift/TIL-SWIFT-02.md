## Codable & Encoding

```Swift
struct HeartData:Codable{

    let hrm:Int
    let presentTime:TimeInterval

    enum CodingKeys: String, CodingKey {
        case hrm
        case presentTime

    }

    init(hrm:Int, presentTime:TimeInterval) {
        self.hrm = hrm
        self.presentTime = presentTime
    }
}

struct HeartRequest:Codable {
    let data : [HeartData]
}
```

```Swift
let data = HeartData(hrm: 98, presentTime: TimeInterval(1575299060000))
let data1 = HeartData(hrm: 111, presentTime: TimeInterval(1575299080000))
let data2 = HeartData(hrm: 85, presentTime: TimeInterval(1575299100000))
let dataList = [data,data1,data2]
let heart = HeartRequest(data: dataList)
```

```Swift
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let jsonData = try? encoder.encode(heart)
if let jsonData = jsonData, let jsonString = String(data:jsonData, encoding: .utf8){
    print(jsonString)
}

```
### 결과
```jsonString
{
  "data" : [
    {
      "hrm" : 98,
      "presentTime" : 1575299060000
    },
    {
      "hrm" : 111,
      "presentTime" : 1575299080000
    },
    {
      "hrm" : 85,
      "presentTime" : 1575299100000
    }
  ]
}

```
