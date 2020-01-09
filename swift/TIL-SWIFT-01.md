# Generic

* 구글에 검색하다보면 Generic이라는 용어를 많이 볼 수 있었다. 언제 한번 봐야지.. 하다가 오늘 보았다!!
---
>Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.
>> 제네릭코드는 함수를 재활용하거나 자료형등을 유연하게 사용할 수 있도록 도와주고, 중복사용을 피하고, 명확한 의도를 가지고 작업할 수 있도록 한다.

>Generics are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code. In fact, you’ve been using generics throughout the Language Guide, even if you didn’t realize it. For example, **Swift’s Array and Dictionary types are both generic collections.** You can create an array that holds Int values, or an array that holds String values, or indeed an array for any other type that can be created in Swift. Similarly, you can create a dictionary to store values of any specified type, and there are no limitations on what that type can be.
>> 사실 스위프트의 배열이나 사전자료형도 제너릭 콜렉션이다. 우리는 이 콜렉션 안에 숫자자료형을 넣을 수도 있고, 특정 오브젝트를 담을 수도 있다. 즉, 사용하는데 제한이 없다.

한 예제를 들어볼 수 있다.
아래와 같은 함수가 있을 때, inout 파라메터를 이용하여 두 값을 서로 바꿔주는 함수이다.
```Swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var x = 10
var y = 200
swapTwoInts(&x, &y) // x = 200, y = 10
```
간단하게 값을 바꿀 수 있는 함수로, 유용하게 사용될 수 있지만 단점은 **Int타입에만 사용될 수 있다는 것이다.**
만약에, Double타입이나 String 타입에도 이러한 기능을 구현하려고 했다면 아래처럼 해야하지 않았을까?

```Swift
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
```
swapTwoString, swapTwoDouble...등등등..
(내 코드에 실제로 이러한 함수가 많다.. )

제네릭을 이용한 함수를 구현하면, 위와 같이 고생하지 않고 유연하게 활용할 수 있다고 한다.

### Generic functions

제네릭 함수는 어떠한 자료형과도 함께 작동할 수 있다.
이제 swap함수는 더이상 swapTwoInt가 아닌, swapTwoValues이다.

```swift
func swapTwoValues<T>(_ a:inout T, _ b:inout T){
  let temporaryA = a
  a = b
  b = temporaryA
}
```

* 위 함수가 swapTwoInt와 함수 내부는 동일하지만, 입력 파라메터 부분이 다르다.
 실제 자료형 이름 대신에 (ex Int, String ..) placeholder type이라는 T가 있다.
* 그래서 미리 이 입력값이 어떤 자료형인지 선언되지 않았지만, 함수가 사용될 때마다 **두 입력값의 자료형이 동일**하면 자료형이 그때마다 함수의 입력값 자료형이 정해진다.


```Swift
func swapTwoValues<T>(_ a:inout T, _ b: inout T){
    let temp = a
    a = b
    b = temp
}
var man = 0
var woman = 1

swapTwoValues(&man, &woman)

var manStr = "man"
var womanStr = "woman"

swapTwoValues(&manStr, &womanStr) // woman , man
print(manStr, womanStr)

```
---
레퍼런스
* [The Swift Programming Language 5.1](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)
