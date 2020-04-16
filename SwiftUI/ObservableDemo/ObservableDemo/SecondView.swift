//
//  SecondView.swift
//  ObservableDemo
//
//  Created by philosys_macbook on 2020/04/16.
//  Copyright © 2020 wonju5332. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
    @ObservedObject var timerData:TimerData = TimerData()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Timer count = \(timerData.timeCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Button(action: resetCount) {
                    Text("Reset Counter")
                }
            }
        }
        
        
    }
    
    func resetCount(){
        timerData.resetCount()
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
