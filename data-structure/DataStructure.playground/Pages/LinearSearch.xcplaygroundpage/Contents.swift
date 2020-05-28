//: [Previous](@previous)

import Foundation


var array = ["Apple","Banana","Cucumbers","dates","elderberries"]

let read = array[0] // O(n)
//[next](@LinearSearch)
//: [Next](@next)

extension Array where Element : Equatable {
    
    func firstIndexCopy(_ search:Element) -> Int? {
            
        for e in self.indices {
            if self[e] == search {
                return e
            }
        }
        return nil
    }
}

["ㅁ","ㄴ"].firstIndexCopy("ㅁ")

