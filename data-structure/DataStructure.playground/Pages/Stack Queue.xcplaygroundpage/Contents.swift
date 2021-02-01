//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

class LintManager{
    private var stack:[String] = []
    private let openingBraces = ["{","[","("]
    private let closingBraces = ["}","]",")"]
    private let pairBrace = ["}" : "{",
                             "]" : "[",
                             ")" : "("]
    
    private enum LintError:Error {
        case incorrectClosingBrace(index:Int, brace:String)
        case nonExistClosingBrace
    }
    
    public func doLint(text:String){
        
        do {
            try parseText(text: text)
        } catch LintError.incorrectClosingBrace(let idx, let wrongBrace) {
            print("IncorrectClosingBrace! at \(idx)  \(wrongBrace)")
            return
        } catch LintError.nonExistClosingBrace {
            print("LintError.nonExistClosingBrace.localizedDescription")
            return
        } catch {
            print(error.localizedDescription)
            return
        }
        print("Lint Test Okay!")
    }
    private func parseText(text:String) throws {
        for (idx,s) in text.enumerated() {
            let str = String(s)
            if openingBraces.contains(str){
                push(str)
            } else if closingBraces.contains(str) {
                if IsCorrectPair(with: str) {
                    pop()
                } else {
                    throw LintError.incorrectClosingBrace(index: idx, brace:str)
                }
            }
        }
        if !stack.isEmpty {
            throw LintError.nonExistClosingBrace
        }
    }
    private func IsCorrectPair(with brace:String)->Bool{
        return pairBrace[brace] == stack.last
    }
    
    private func push(_ bracing:String){
        stack.append(bracing)
    }
    
    private func pop(){
        stack.popLast()
    }
}
//: ### 큐

class PrintManager {
    private var queue:[String] = []
    
    public func job(doc:String){
        print("job : \(doc)")
        queue.append(doc)
    }
    
    func run(){
        if queue.isEmpty {
            print("no job no print")
            return
        }
        
        while !queue.isEmpty {
            let pick = queue.removeFirst()
            print("print : \(pick)")
            
        }
        print("all jobs are clear")
    }
    
    private func doPrint(doc:String){
        
    }
}

let manager = PrintManager()
manager.job(doc: "h1")
manager.run()
//: [Next](@next)
