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
            
            Form {
                Section(header: Text("2021-09-09 Thu")) {
                    Text("Webデザインの練習")
                    Text("SwiftUIの練習")
                    Text("買い物した")
                }
                
                Section(header: Text("2020-09-08 Wed")) {
                    Text("ゲーム楽しかった")
                    Text("料理した")
                    Text("いっぱい寝た")
                }
                
                Section(header: Text("2020-09-07 Tue")) {
                    Text("風邪が治った")
                    Text("買い物に行った")
                    Text("洗濯した")
                }
            }
            
                
                
            .navigationBarTitle("3 Points Diary", displayMode: .inline)
            .navigationBarItems(trailing:
                Button("White"){
                    print("hello")
                }
            )
                
            
        }
    }
}


