# 19 커스텀뷰 생성하기

1. SwiftUI 뷰
- SwiftUI에서 뷰는 View 프로토콜을 따르는 구조체로 선언된다.
- View 프로토콜을 따르려면 body 프로퍼티를 구현해야 하며, 이 안에 뷰가 선언되어야 한다.
- 뷰의 속성을 변경하기 위해서는 수정자를 이용한다. (modifier)
- 재사용 가능한 뷰 컴포넌트를 캡슐화하여 관리하기 위해서는 최대한 작은 단위의 모듈로 나눌 것을 권한다.

```swift
import SwiftUI

struct ContentView:View {
  var body: some View {
    Text("Hello, World")
  }
}
```

- 뷰를 추가하기 위해서는 stack이나 form같은 **컨테이너뷰** 내부에 뷰들을 배치해야 한다.


```swift
import SwiftUI

struct ContentView:View {
  var body: some View {
    VStack {
      Text("Hello, World")
      Text("Hello, World")
    }

  }
}
```

- 여러 뷰를 서로 연결하면 하나의 뷰로 간주된다. 따라서 다음의 코드도 유효하다.


```swift
import SwiftUI

struct ContentView:View {
  var body: some View {

    Text("Hello!") + Text("World")


  }
}
```

- body 프로퍼티에는 반환식이 필요없다. 그러나, 별도의 표현식이 추가되는 경우엔 return 구문이 필요하다.

```swift
import SwiftUI

struct ContentView:View {
  var body: some View {
    let firstString : String = "HelloWorld"

    return Vstack {
      Text("Hello")
      Text("World")
    }
  }
}
```

- body 프로퍼티 내에 구현한 커스텀 뷰가 복잡하면, 뷰 프로토콜을 따르는 커스텀 뷰를 새로 구현하여 사용할 수 있다.

```swift

struct ContentView:View {
  var body: some View {
    VStack {
      MyHStackView()
      Text("!!!")
    }

  }
}

struct MyHStackView: View {
  var body: some View {
    HStack {
      Text("Hello")
      Text("World")
    }
  }
}
```

- 하위뷰를 생성하는 또 다른 방법으로, 프로퍼티로서의 뷰로 구현할 수 있다.

```swift

struct ContentView:View {
  let carStack = Hstack {
    Text("Car Image")
    Image(systemName:"car.fill")
  }
  var body: some View {
    VStack {
      carStack
      Text("!!!")
    }

  }
}
```

- 수정자 순서에 따라, 적용되는 순서가 영향을 받기 때문에 유의해야 한다.

```swift
Text("Sample Text")
  .border(Color.black)
  .padding()
  // 경계선이 먼저 생긴 후, 패딩은 경계선 밖에 생김

Text("Sample Text")
  .padding()
  .border(Color.black)
  // 패딩이 먼저 생긴 후, 패딩 바깥에 경계선이 생긴다.
```

- 커스텀 수정자를 생성하여, 자주 쓰는 수정자들을 묶어서 활용할 수 있다.

```swift

struct StandardTitleModifier : ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .background(Color.white)
      ...

  }
}

// 사용예시
Text("Text 1")
  .modifier(StandardTitleModifier())
Text("Text 2")
  .modifier(StandardTitleModifier())

```

- 사용자 인터페이스인 뷰를 조작 시, 발생하는 이벤트 처리하기
```swift

var body: some View {
  Button(action:buttonPressed){
    Text("Click Me")
  }
}
func buttonPressed() {
  // action
}

or

Button(action : {

}) {
    Text("Click me")
}
```

- 레이아웃 안에 뷰가 나타나거나, 사라질 때 수행하기 위한 작업..
```swift
Text("Heelo")
  .onAppear(perform:{

  })
  .onDisappear(perform: {

  })
```

- 하위뷰의 한계는 컨테이너뷰의 콘텐트가 정적이라는 것이다. 즉, 컨테이너 안에 하위뷰가 포함 되는 시점에, 포함될 뷰의 종류들을 동적으로 지정할 수가 없다.
- 즉, 하위뷰에 포함되는 뷰들은 최초선언부에 지정된 하위뷰들 뿐이다.
- 이를 해결하기 위해, 최초선언부에 동적으로 하위뷰를 지정할 수 있도록 **커스텀 컨테이너 뷰** 를 만든다.



### SwiftUI 스택과 프레임

* SwiftUI는 다양한 종류의 인터페이스 컴포넌트를 가지고있다. (버튼,레이블, 슬라이더,토글 등)

#### Swift UI 스택

* 수직, 수평, 중첩 형태인 총 3개의 스택 레이아웃 뷰를 제공한다.

* 기존의 컴포넌트를 스택에 포함시키려면, 컴포넌트를 스택 선언부안에 직접 넣거나, 코드에디터에 있는..커맨드 키 누르고 컴포넌트 클릭!

#### Spacer, alignment, padding
* 뷰 사이에 공간을 추가하기 위한 Spacer 컴포넌트가 있다. 스택뷰 안에서 사용하면 스택의 방향에 따라 유연히 확장,축소한다.

* 스택의 정렬은 스택이 선언될 때 정렬값을 지정하면 된다. 간격값을 넣을수도 있다.

```swift
VStack(alignment: .center, spacing: 15) {
           Text("Financial Results")
               .font(.title)
           HStack(alignment: .top) {
               Text("Q1 Sales")
                   .font(.headline)
               Spacer()
               VStack(alignment: .leading) {
                   Text("Jan")
                   Text("Feb")
                   Text("Mar")
               }
               Spacer()
               VStack {
                   Text("$1000")
                   Text("$200")
                   Text("$3000")
               }
           }
       }
```


#### 컨테이너의 자식 뷰 제한

* 컨테이너 뷰는 직접적인 하위뷰를 10개로 제한한다. 만약 10개 이상의 자식뷰를 담으면 다음과 같은 구문 오류가 표시된다.

```
Argument passed to call that takes no argument
```

* 10개를 넘어야 하는 경우, 그룹뷰를 이용할 수 있다.

* Text 뷰가 12개인 경우

```swift
VStack {
    Group {
        Text("Sample Text")
        Text("Sample Text")
        Text("Sample Text")
        Text("Sample Text")
        Text("Sample Text")
        Text("Sample Text")
    }
    Group {
        Text("Sample Text")
        Text("Sample Text")
        Text("Sample Text")
        Text("Sample Text")
        Text("Sample Text")
        Text("Sample Text")
    }

}
```

#### 텍스트 줄 제한과 레이아웃 우선순위

layoutPriority()수정자를 이용하여 뷰의 우선순위를 적용할수 있는데 , 이 수정자는 스택에 있는 뷰에 추가될 수 있다.

```swift
HStack {
    Image(systemName: "airplane")
    Text("Flight times:").layoutPriority(3)
    Text("London").layoutPriority(2)
}
.padding(40)
.font(.largeTitle)
.lineLimit(1)
```

#### SwiftUI 프레임

* 기본적으로, 뷰는 자신의 콘텐츠와 속한 레이아웃에 따라 자동으로 크기가 조절된다. 때로는 뷰 자체가 특정 영역에 맞아야 한다.
* 이를 위해 frame 수정자가 있다.

```swift
Text("Hello World World")
  .font(.largeTitle)
  .padding(10)
  .border(Color.black)
  .frame(width: 100, height: 150, alignment: .center)
```

* 고정된 문자에 고정된 크기인 경우 문제가 없으나 동적으로 텍스트가 변하는 경우는 문제가 발생할 수 있다. 이 때 frame 내에 최소,최대 영역을 지정하면 유연해질 수 있다.

```Swift
Text("Hello World, how are you?")
  .font(.largeTitle)
  .border(Color.black)
  .frame(minWidth: 100, maxWidth: 300, minHeight: 100, maxHeight: 100, alignment:  .center)
```


* 하지만 더 긴 텍스트가 오면 표시에 문제가 생긴다. 이때 최소 최대값을 0과 무한대로 설정하여 가능한 **모든 영역을 차지** 하도록 구성할 수 있다.

```swift
Text("Hello World, how are you?")
  .font(.largeTitle)
  .border(Color.black)
  .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:  .center)
```

* 여러 수정자가 연결되면 뷰의 모양에 영향을 미친다. 위 코드에서 사용가능한 영역의 경계선을 그린다고 하면, border 수정자를 뒤로보낸다.

```swift
Text("World, how are you?")
  .font(.largeTitle)
  .frame(minWidth: 300, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:  .center)
  .border(Color.black)
```

#### 프레임과 GeometryReader

* 프레임은 뷰들을 담고 있는 컨테이너의 크기에 따라 조절되도록 구현할 수도 있다.

* GeometryReader로 뷰를 감싸고, 컨테이너의 크기를 식별하기 위한 리더를 이용하여 할 수 있다.

```swift
GeometryReader { geometry in

    VStack {
        Text("World, how are you?")
            .font(.largeTitle)
            .frame(width: geometry.size.width / 2, height: (geometry.size.height / 4) * 3)
        Text("World, how are you?")
            .font(.largeTitle)
            .frame(width: geometry.size.width / 3, height: (geometry.size.height / 4) * 3)
    }
}
// 위 텍스트는 VStack의 너비의 1/2만큼의 너비를 가지고, Vstack의 높이의 3/4높이를 차지한다.
```


### 상태, Obserable 객체, Environment 객체로 작업하기

* swiftui 는 데이터 주도 방식으로 앱개발을 강조한다. 데이터 변경에 따른 뷰 업데이트 코드를 작성하지 않아도 된다. 이것은 게시자와 구독자를 구축하여 할 수 있다.

* 이를 위하여 SwiftUI는 상태프로퍼티, Obserable객체, 그리고 Environment객체를 제공하며, 이들 모두는 사용자 인터페이스의 모양과 동작을 결정하는 상태를 제공한다.

* 레이아웃을 구성하는 뷰는 **코드 내에서 직접 업데이트 하지 않는다.** 그 대신 뷰와 바인딩된 상태 객체가 변하면 자동으로 뷰가 업데이트 된다.

* 상태 프로퍼티는 상태에 대한 기본적인 형태이다. 뷰 레이아웃의 현재상태(토글 활성화여부, 텍스트필드의 텍스트, 피커뷰의 현재값 등). 상태 프로퍼티는 String or Int 값처럼 간단한 데이터 타입을 저장하기 위해 사용되며. @state 프로퍼티 래퍼를 사용하여 선언된다.

* 상태 값은 해당 뷰에 속한 것이기 때문에 **private 프로퍼티** 로 선언되어야 한다.

* 상태 프로퍼티 값이 변경되었다는 것은 그 프로퍼티가 선언된 뷰 계층구조를 다시 렌더링해야 한다는 SwiftUI신호다.

* 상태프로퍼티는 뷰에 바인딩할 수 있다.

```swift
import SwiftUI

struct chapter21: View {
    @State private var wifiEnabled = true
    @State private var userName = ""

    var body: some View {
        VStack{
            TextField("enter user name ", text: $userName)
        }
    }
}
```

* 상태프로퍼티에 저장할 때는 $UserName 이런식으로 하고, 사용할 때는 UserName 으로 사용하면 된다.

#### 상태 바인딩

* 만일, 하위뷰에서 상태프로퍼티를 쓰고자할 때에는 임의의 상태프로퍼티를 작성하고 앞에 @Binding 을 붙인 후에 입력 파라메터로 입력값을 받으면 사용할 수 있다.

```swift
struct chapter21: View {
    @State private var wifiEnabled = true
    @State private var userName = ""

    var body: some View {
        VStack{
            Toggle(isOn: $wifiEnabled) {

                Text("Enable Wi-fi")
            }
            TextField("enter user name ", text: $userName)
            Text(userName)
            WifiImageView(wifiEnabled: wifiEnabled)
    }
}
struct WifiImageView:View {
    @Binding var wifiEnabled : Bool
    var body: some View {
        Image(systemName:wifiEnabled ? "wifi" : "wifi.slash")
    }


}
```

#### Observable 객체

* 상태 프로퍼티는 해당 뷰 또는 바인딩이 구현되어 있는 하위뷰에만 사용할 수 있다.
* Observable 객체는 다른 뷰들이 외부에서도 접근할 수 있다.

* Combine 프레임워크에 포함되어 있는 Observable 객체는 게시자와 구독자 간의 관계를 쉽게 구축할 수 있도록 iOS 13에 도입되었다.

#### Environment 객체

* A에서 B로 이동(navigation)하는데, 이동될 뷰에서도 동일한 구독 객체에 접근해야 한다면 어떻게 해야 할까. 이동할 때 대상 뷰로 구독 객체에 대한 참조체를 전달해야할 것이다.

```swift
NavigationLink(destination:SecondView(demoData)) {
  ......
}
```
* 위와 같은 접근방법은 복잡해질 수 있다.이런 상황에서는 Environment 객체를 사용하는것이 더 합리적일 수 있다.

* Environment객체는 Observable 객체와 같은 방식으로 선언된다. 즉 반드시 **Observable Object** 프로토콜을 따라야 하며, 적절한 프로퍼티도 게시되어야 한다.

* 중요한 차이점은 이 객체는 SwiftUI 환경에 저장되며, 뷰에서 뷰로 전달할 필요 없이, 모든 뷰가 접근할 수 있다!

* 대신 Environment객체를 구독해야 하는 객체는 @ObservedObject 대신  @EnvironmentObject 를 이용하여 객체를 참조하면 된다.
