//
//  ContentView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("日記一覧")
                }
            SecondView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("カレンダー")
                }
        }
    }
}
