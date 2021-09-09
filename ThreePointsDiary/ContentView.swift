//
//  ContentView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            
            Text("ここに日記一覧を表示する予定")
                .padding()
            
            .navigationBarTitle("3 Points Diary", displayMode: .inline)
            .navigationBarItems(trailing:
                Button("White"){
                    print("hello")
                }
            )
                
            
        }
    }
}


