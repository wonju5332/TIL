//: [Previous](@previous)

import Foundation

//O(N^2), 또는 이차 시간
func bubbleSort(with array:[Int]){
    let oldValue = array
    var array = array
    var sorted = false
    var loopCount = array.count - 1
    
    //로깅변수
    var cnt = 0
    while !sorted {
        cnt += 1
        sorted = true
        for i in 0..<loopCount {
            if array[i] > array[i + 1] {
                
                sorted = false
                let temp = array[i]
                array[i] = array[i + 1]
                array[i + 1] = temp
            }
        }
        loopCount -= 1
    }
    print("----------------- result -----------------")
    print(" \(oldValue) -> \(array) ")
    print("----------------- Loop Time : \(cnt) -----------------")
    
}
let data = [4,2,7,1,3,993]
//bubbleSort(with: data)
// 선택정렬
func selectSorting(with array:[Int]){
    var oldValue = array
    var array = array
    var minValueIndex = 0

    for i in 0..<array.count {
        minValueIndex = i
        for j in (i+1)..<array.count{
            if array[minValueIndex] > array[j] {
                minValueIndex = j
            }
        }
        if minValueIndex != i {
            let temp = array[i]
            array[i] = array[minValueIndex]
            array[minValueIndex] = temp
        }
    }
    

    print("----------------- result -----------------")
    print("""
        \(oldValue)
        \(array)
""")
    print("------------------------------------------")
//    print("----------------- Loop Time : \(cnt) -----------------")
}
func insertSort(with array:[Int]){
    var array = array

    for i in 1..<array.count {
        
        var pointer = i
        let tempVal = array[i] //pick
        
        while pointer > 0 && array[pointer-1] > tempVal {
            array[pointer] = array[pointer-1]
            pointer -= 1
        }
        array[pointer] = tempVal
    }
    print(array)
}



func main(){
    
}

main()

//: [Next](@next)
