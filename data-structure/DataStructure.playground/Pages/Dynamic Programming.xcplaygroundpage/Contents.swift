//: [Previous](@previous)

import Foundation
/*
 자신을 호출한다, 수열에 귀납적 정의
 재귀를 사용할 때는 항상
 1. 종료 조건을 정의한다.
 2. 전체 작업의 일부만 수행하고, 나머지는 재귀 호출에 위임한다.
   작업 일부 수행이란?
    - sum(n:Int) 함수의 경우, (n+1)에 n을 더하는 작업
   
 */
func sum(n:Int) ->Int{
    if n <= 0 {
        return 0
    }
    if n == 1 {
        return 1
    }
    return n + (n+1)
}

//: * 연습문제 1-1
//: 음이 아닌 정수를 인수로 받아, n의 계승을 반환하는 함수를, 재귀 또는 재귀 사용하지 않는 방식으로 작성해보아라.

func rFactorial(n:Int)-> Int{
    if n <= 0 {
        return 0
    }
    
    if n == 1 {
        return 1
    }
    return n * rFactorial(n: n - 1)
}

func factorial(n:Int) -> Int {
    if n <= 0 {
        return 0
    }
    if n == 1 {
        return 1
    }
    var result = n
    
    for num in 1...n - 1 {
        result *= num
    }

    return result
}

//: * 연습문제 1-2
//: 정수 값의 배열이 주어졌을 때, 배열의 각 원소를 누적합으로 갱신하는 재귀 함수를 작성하라.
//: ex) [1,2,3,4,5,6] -> [1,3,6,10,15,21]
/*
  종료조건 : 배열의 원소가 배열의 크기와 같으면 현재 배열을 반환할 것
  일부작업 : 배열을 카피하고, 각 원소값을 더해 카피한 배열에 할당하고, 재귀함수 호출하여 인자로 넘긴다.
 
 */

func cumulativeSum(array:[Int], index:Int = 0) ->[Int]{
    if index == array.count - 1 {
        return array
    }
    var tempArray = array
    tempArray[index + 1] = array[index] + array[index + 1]
    return cumulativeSum(array: tempArray, index: index + 1)
}


func pow(x:Int, n:Int) -> Int{
    if n == 0 {
        return 1
    }
    if x == 1 {
        return 1
    }
    return x * pow(x: x, n: n - 1)
}
pow(x: 2, n: 15)

/*
 함수 중요도순으로 주의하라
 1.함수는 목적 지향적이어야 한다. 의도한 대로 동작해야 하며, 모호한 결과가 반환되어서는 안된다.
 2.수행필요시간이 짧을수록 좋다.
 3.필요 메모리 크기가 작을수록 좋다.
 4.이해하기 쉬워야 한다. 주석이 없더라도 이해할 수 있어야 좋은 코드이다.
 
 그러나, 일반적으로 재귀호출은 일반 구체화 방법보다 메모리와 시간이 더 들여진다.
 */

/*
 예제 하노이의 탑
 하노이의 탑에는 3개의 기둥이 있다.
 S-출발지
 D-목적지
 E-임시
 그리고 n 개의 서로 다른 크기의 원반이 있으며, 어느 기둥에나 꽂을 수 있다.
 
 최초에는 출발지에 n개의 원반이 크기순으로 꽂혀있다.
 한번에 하나의 원반만 옮길 수 있다.
 작은 원반 위에 큰 원반이 위치하도록 옮길 수 없다.
 
 */

func towerOfHanoi(s:String, d:String, e:String, n:Int){
    print("s : \(s) d: \(d) e: \(e) n:\(n)")
    if n <= 0 {
        return
    }
    towerOfHanoi(s: s, d: e, e: d, n: n-1)
    print("\(n)번 원반을 \(s)에서 \(d)으로 옮긴다.")
    towerOfHanoi(s: e, d: d, e: s, n: n-1)
    
}
//towerOfHanoi(s: "s", d: "d", e: "e", n: 3)




//: [Next](@next)

//:


