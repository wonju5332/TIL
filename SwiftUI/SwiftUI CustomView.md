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
