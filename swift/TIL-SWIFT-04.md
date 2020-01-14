## Enum & Codable

* 웨어러블 장치의 설정값을 컨트롤을 하기 위한 기능을 구현하고 있었다.
* struct와 enum 을 이용하여 상태값을 저장하고, 불러와서 사용할 예정이었다. 모두 구현하고 나니, 문제가 생겼다.
* 이 오브젝트를 data로 인코딩하거나, 또는 data를 다시 오브젝트화 하려면 codable 프로토콜을 채택해서 사용해야 한다.
* struct 와 codable의 경험은 있는데, enum과 중첩 struct가 사용되는 등, 조금 더 복잡하게 사용이 되고 있어 정리하고자 한다.

---

* 밴드화면의 방향을 설정하는 구조체이다.
* enum의 string value는 설정에 표시될 값이 되기도 한다.
* 테이블에 활용할 수 있도록 CaseIterable을 채택했다.
* 코드 구분을 위하여, codable 채택 및 명세부분은  extension으로 분리해놓았다.

```swift
enum DisplayOrientationType:String , CaseIterable{
    case portrait = "가로"
    case landscape = "세로"
}


extension DisplayOrientationType: Codable {

    enum Keys: CodingKey {
        case rawValue
    }

    enum CodingError: Error {
        case unknownValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "가로":
            self = .portrait
        case "세로":
            self = .landscape
        default:
            throw CodingError.unknownValue
        }
    }


    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        switch self {
        case .portrait:
            try container.encode("가로", forKey: .rawValue)
        case .landscape:
            try container.encode("세로", forKey: .rawValue)

        }
    }

}

let display = DisplayOrientationType(rawValue: "세로") // landscape
let encoder = JSONEncoder()
let data = try encoder.encode(display)

let decoder = JSONDecoder()
let decoding = try decoder.decode(DisplayOrientationType.self, from: data) // landscape

 ```




### 처음에는 아래와 같았던 코드가
```swift
struct BandSetting:Codable {
    var isConnectState:Bool
    var notification:BandNotification
    var isDisplayWhenWristRotate:Bool
    var displayOrientation:DisplayOrientationType
    var bandTimeFormat:BandTimeFormatType
    var ppgCycleNormal:BandMeasureCycle.PPG.NormalPPG
    var ppgCycleWork:BandMeasureCycle.PPG.WorkingPPG

    struct BandNotification:Codable {
        var isPhone:Bool
        var isSms:Bool
    }

    struct BandMeasureCycle:Codable {
      var ppg:PPG
        struct PPG:Codable {
            var normal:NormalPPG
            var working:WorkingPPG

            enum WorkingPPG:String , CaseIterable,Codable{
                case minOf3 = "3분"
                case realtime = "실시간"
            }
            enum NormalPPG:String , CaseIterable, Codable{
                case quarter = "15분"
                case half = "30분"
                case hour = "1시간"
                case off = "사용 안함"
            }
        }
    }



    enum DisplayOrientationType:String , CaseIterable, Codable{
        case portrait = "가로"
        case landscape = "세로"
    }
    enum BandTimeFormatType:String , CaseIterable, Codable{
        case half = "12시간"
        case full = "24시간"
    }
}
```
### 아래처럼 변했다.
```swift
struct BandSetting:Codable {

    var isConnectState:Bool
    var notification:BandNotification
    var isDisplayWhenWristRotate:Bool
    var displayOrientation:DisplayOrientationType
    var bandTimeFormat:BandTimeFormatType
    var bandMeasureCycle:BandMeasureCycle

    enum BandSettingCodingKeys:CodingKey{
        case isConnectState
        case notification
        case isDisplayWhenWristRotate
        case displayOrientation
        case bandTimeFormat
        case bandMeasureCycle
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BandSettingCodingKeys.self)
        isConnectState = try container.decode(Bool.self, forKey: .isConnectState)
        notification = try container.decode(BandNotification.self, forKey: .notification)
        isDisplayWhenWristRotate = try container.decode(Bool.self, forKey: .isDisplayWhenWristRotate)
        displayOrientation = try container.decode(DisplayOrientationType.self, forKey: .displayOrientation)
        bandTimeFormat = try container.decode(BandTimeFormatType.self, forKey: .bandTimeFormat)
        bandMeasureCycle = try container.decode(BandMeasureCycle.self, forKey: .bandMeasureCycle)

    }

    init(connectState:Bool, whenWristRotate:Bool, notify:BandNotification,
         orientation:DisplayOrientationType, timeformat:BandTimeFormatType, measureCycle:BandMeasureCycle){

        isConnectState = connectState
        notification = notify
        isDisplayWhenWristRotate = whenWristRotate
        displayOrientation = orientation
        bandTimeFormat = timeformat
        bandMeasureCycle = measureCycle

    }
}


struct BandNotification:Codable {
    var isPhone:Bool
    var isSms:Bool

    enum BandNotiCodkingKeys:CodingKey{
        case isPhone
        case isSms
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BandNotiCodkingKeys.self)
        isPhone = try container.decode(Bool.self, forKey: .isPhone)
        isSms = try container.decode(Bool.self, forKey: .isSms)
    }

    init(phone:Bool, sms:Bool){
        isPhone = phone
        isSms = sms
    }
}


struct BandMeasureCycle:Codable {
    var ppg:PPG

    enum BandMeasureCycleKeys:CodingKey{
        case ppg
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BandMeasureCycleKeys.self)
        ppg = try container.decode(PPG.self, forKey: .ppg)
    }
    init(ppg data:PPG) {
        ppg = data
    }
}
struct PPG:Codable {
    var normal:NormalPPG
    var working:WorkingPPG

    enum WorkingPPG:String , CaseIterable{
        case per3min = "3분"
        case realtime = "실시간"
    }
    enum NormalPPG:String , CaseIterable{
        case quarter = "15분"
        case half = "30분"
        case hour = "1시간"
        case off = "사용 안함"
    }
    enum PPGCodingKeys:CodingKey{
        case normal
        case working
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PPGCodingKeys.self)
        normal = try container.decode(NormalPPG.self, forKey: .normal)
        working = try container.decode(WorkingPPG.self, forKey: .working)
    }

    init(normal x1: NormalPPG, working x2: WorkingPPG){
        normal = x1
        working = x2
    }
}

extension PPG.WorkingPPG : Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "3분":
            self = .per3min
        case "실시간":
            self = .realtime
        default:
            throw CodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        switch self {
        case .per3min:
            try container.encode("3분", forKey: .rawValue)
        case .realtime:
            try container.encode("실시간", forKey: .rawValue)

        }
    }
}

extension PPG.NormalPPG : Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
            case "15분":
                self = .quarter
            case "30분":
                self = .half
            case "1시간":
                self = .hour
            case "사용 안함":
                self = .off
        default:
            throw CodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = try encoder.container(keyedBy: Keys.self)
        switch self {
        case .quarter:
            try container.encode("15분", forKey: .rawValue)
        case .half:
            try container.encode("30분", forKey: .rawValue)
        case .hour:
            try container.encode("1시간", forKey: .rawValue)
        case .off:
            try container.encode("사용 안함", forKey: .rawValue)
        }
    }
}



enum Keys: CodingKey {
    case rawValue
}

enum CodingError: Error {
    case unknownValue
}


enum DisplayOrientationType:String , CaseIterable{
    case portrait = "가로"
    case landscape = "세로"
}
enum BandTimeFormatType:String , CaseIterable{
    case half = "12시간"
    case full = "24시간"
}


extension BandTimeFormatType: Codable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "12시간":
            self = .half
        case "24시간":
            self = .full
        default:
            throw CodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        switch self {
        case .half:
            try container.encode("12시간", forKey: .rawValue)
        case .full:
            try container.encode("24시간", forKey: .rawValue)

        }
    }

}

extension DisplayOrientationType: Codable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "가로":
            self = .portrait
        case "세로":
            self = .landscape
        default:
            throw CodingError.unknownValue
        }
    }


    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        switch self {
        case .portrait:
            try container.encode("가로", forKey: .rawValue)
        case .landscape:
            try container.encode("세로", forKey: .rawValue)

        }
    }

}
```
---
* 하면서 들었던 생각은, 이정도 작업은 콜렉션타입으로 해결해도 되지않았을까. 생각이 들기도 했다.

* 처음에는, 구조체를 이용하면 더 편리하게 사용할 수 있고, enum을 사용해서 가독성도 높히고, 좋은 것 같은데 그만큼 코딩시간이 투자가 필요하기도 했다.
* data로 저장되야 하기때문에 coder기능을 구현하다보니, 점점 더 복잡해진 것 같다..
* 그럼에도 불구하고, 이렇게 사용한 이유는, 옵젝씨 프로젝트 유지보수할 때, 단 한개의 클래스와 구조체, 열거형 조차 사용되지 않고 오로지 딕셔너리와 sqlite로 구성되어 있었는데, 개발할 때 너무 힘들었던 기억이 있었다.
* 다른 사람이 내 코드를 유지보수할 때 보다 편리하게끔 해주고 싶어서, 최대한 편의성을 제공할 수 있는 코드를 짜려고 한다.
...

그런데, mutating 을 따로 쓰지 않았는데 왜 구조체의 값들이 변경가능한 것인지 모르겠다..
공부가 더 필요하다.
