//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by philosys_macbook on 2020/04/08.
//  Copyright © 2020 philosys. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var colors : [Color] = [.black, .red, .green, .blue]
    var colornames = ["black", "red", "green", "blue"]
    
    @State private var colorIndex = 0
    @State private var rotation: Double = 0
    @State private var text: String = "Welcome to SwiftUI"
    var body: some View {
        VStack {
            Spacer()
            Text(text).foregroundColor(colors[self.colorIndex])
                .font(.largeTitle)
                .fontWeight(.heavy)
                .rotationEffect(.degrees(self.rotation))
                .animation(.easeInOut(duration:5))
            Spacer()
            Divider()
            Slider(value: $rotation, in: 0 ... 360, step: 0.1)
                .padding()
            TextField("Enter Text Here!!", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            
            
            
            Picker(selection: $colorIndex, label:Text("Picker")) {
                ForEach (0 ..< colornames.count) {
                    Text(self.colornames[$0])
                        .foregroundColor(self.colors[$0])
                    
                }
            }
        .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
