//
//  ContentView.swift
//  ObservableDemo
//
//  Created by philosys_macbook on 2020/04/16.
//  Copyright © 2020 wonju5332. All rights reserved.
//

// ObservableDemo 객체는 동적 데이터를 래핑하는데 효율적이다.
// 시뮬레이션을 위해, 타이머 객체를 사용하여 매 초마다 카운터가 업데이트 되도록 구성하여 데이터 객체 생성 하고,  Environment객체로 생성하여 다른 뷰에서 접근할 수 있도록 생성.

import SwiftUI


struct ContentView: View {
    
//    @ObservedObject var timerData:TimerData = TimerData()
    @EnvironmentObject var timerData : TimerData
    
    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Timer count = \(timerData.timeCount)")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding()
//                Button(action: resetCount) {
//                    Text("Reset Counter")
//                }
//                // 하나의 옵저버블 객체 인스턴스를 두개의 뷰가 구독하고 있는 방법
//                NavigationLink(destination: SecondView(timerData: timerData)) {
//                    Text("Next Screen")
//                }
//            .padding()
//            }
//        }
        NavigationView {
            NavigationLink(destination: SecondView()) {
                Text("Next Screen\(timerData.timeCount)")
            }
        .padding()
        }
        
        
    }
    
    func resetCount(){
        timerData.resetCount()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TimerData())
    }
}
