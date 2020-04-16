//
//  SecondView.swift
//  ObservableDemo
//
//  Created by philosys_macbook on 2020/04/16.
//  Copyright © 2020 wonju5332. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
//    @ObservedObject var timerData:TimerData = TimerData()
    @EnvironmentObject var timerData:TimerData
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
//            }
//        }
        VStack {
            Text("Second View")
                .font(.largeTitle)
            Text("Timer Count = \(timerData.timeCount)")
                .font(.headline)
        }.padding()
        
        
        
        
    }
    
    func resetCount(){
        timerData.resetCount()
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView().environmentObject(TimerData())
    }
}
