# Swift는 프로토콜 지향적 언어?

* 2015 WWDC에서 Swift 2.0을 발표하면서 이 언어는 프로토콜 지향적 언어라고 발표했다고 한다.
* 프로토콜 지향적 언어라고 표현한 이유는 무엇인지, 그리고 어떻게 준수하고 사용하는 것인지, 장점은 무엇인건지 간단히 공부해보았다.

---
* swift의 API 대부분은 클래스가 아닌, 구조체로 구현되어 있다. 구조체는 클래스와 달리 상속이 불가능하기 때문에 각종 오브젝트들을 활용하는데 어려움이 있었을 것이다.
* 그럼 클래스로 상속받으면서 설계를 했으면 됬을텐데 그렇게 하지 않은 이유는 무엇일까
* 부모클래스를 상속받은 자식클래스는 의존성이 높아진다. 또한 일부 필요한 기능들만을 선택해서 상속받기도 어렵다. 그러니 비효율적인 상속이 빈번하게 일어날 수 있다.(배보다 배꼽이 더 큰..? objC에서 NSObject 를 상속받는..?)
* 프로토콜은 이러한 문제를 해결하고, 의존성도 낮추고 보다 더 작은 단위의 상속을 받을 수 있게끔 하려고 했고, 이를 준수하는 프로그래밍 언어가 프로토콜 지향적 언어이다.(제 생각입니다..)

* 그래서 프로토콜을 만들고, 이를 준수하는 구조체를 만들고, 명세된 프로퍼티와 함수를 구현하면 되는데, 문제점이 있다.
* 상속받는 구조체들은 매번 채택한 프로토콜의 값들을 일일이 구현해줘야 하는 문제가 있다.(optional로 처리하거나?)
* 이를 해결할 수 있는 방법이 바로 Extension이다. 이 Extension은 미리 프로토콜의 명세를 구현해둘 수 있다. 즉 초기화값을 미리 구현해놓을 수 있기 때문에, 필요에 따라 "오버라이드"하는 것처럼 변수나 함수를 구현하여 사용하면 된다.(오버라이드는 아니다)

### 간단한 예

```swift
protocol ResponseProtocol {
    var result:String{get set}
    var message:String{get set}
    var messageCode:String{get set}
    func printMessage()
}

struct HealthData:ResponseProtocol {
    var result: String
    var message: String
    var messageCode: String
    var data:[String]
    func printMessage(){
        print("CODE \(messageCode) : \(message) \(result)\n")
    }
}

let health = HealthData(result: "Success",
                      message: "Your Data is Saved",
                      messageCode: "001",
                      data:["PullUp","regPress"] )
health.printMessage()
//CODE 001 : Your Data is Saved Success

```


* 서버 API로부터 전달받은 결과값을 처리하는 프로토콜과 그것을 준수하는 구조체이다.
* Response의 결과를 디버깅하기 위해 printMessage 메소드를 만들어 둔 상태이고, 구조체에서는 내용을 구현한 상태이다.
* 모든 데이터관련된 구조체들이 Response 프로토콜을 준수하면 동일한 변수와 함수를 사용할 수 있을테니, 안전하고 사용성있고, 한결같은 프로그래밍을 할 수 있을 것이다!!
* 그런데, 데이터 관련된 구조체가 10개 20개가 된다면..?
* 매번 printMessage메소드 내용을 구현해줘야 할까..그렇다면 완전 비효율적일 것이다. 이때 extension으로 메소드 초기구현을 처리해준다.

```Swift

protocol ResponseProtocol {
    var result:String{get set}
    var message:String{get set}
    var messageCode:String{get set}
    func printMessage()
}

struct HealthData:ResponseProtocol {
    var result: String
    var message: String
    var messageCode: String
    var data:[String]
    
}

extension ResponseProtocol {
    func printMessage(){
        print("CODE \(messageCode) : \(message) + \(result)\n")
    }
}


let health = HealthData(result: "Success",
                      message: "Your Data is Saved",
                      messageCode: "001",
                      data:["PullUp","regPress"] )
health.printMessage()
//CODE 001 : Your Data is Saved Success
```

* 구조체에서 printMessage 를 구현하지 않았지만, extension에서 초기구현을 한 덕분에 편하게 메소드를 사용할 수 있게 되었다.
* 만일 해당 메소드를 다르게 구현하고 싶다면, 원래 하던대로 구조체에 메소드를 구현하면 될 일이다.

```Swift
Protocol ...

struct HealthData:ResponseProtocol {
    var result: String
    var message: String
    var messageCode: String
    var data:[String]
    func pringMessage(){
      print("CODE 000 : HealthData is Saved \(result)")
    }
}

extension ResponseProtocol {
    func printMessage(){
        print("CODE \(messageCode) : \(message) + \(result)\n")
    }
}


let health = HealthData(result: "Fail",
                      message: "HealthData is Saved",
                      messageCode: "001",
                      data:["PullUp","regPress"] )
health.printMessage()
//CODE 000 : HealthData is Saved Fail

```

* 앞으로 최대한 스위프트다운 프로그래밍을 하려면, 이러한 스킬들을 자주 사용하고 싶다는 생각이 들었다. 재미도 있고, 코드가 깔끔해지는 것 같아서 좋다!
