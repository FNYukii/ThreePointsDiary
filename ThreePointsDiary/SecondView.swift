//
//  SecondView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI
import RealmSwift

struct SecondView: View{
    
    //カレンダー上で選択された日付
    @State var selectedDate = Date()
        
    var body: some View {
        
        Form {
            Section {
                CalendarView(selectedDate: $selectedDate)
                    .frame(height: 350)
                    .onChange(of: selectedDate, perform: { value in
                        searchDiary()
                    })
            }
            Section(header: Text("2021年 9月 7日 火")) {
                Text("Homework completed")
                Text("Shopping done")
                Text("slept a lot")
            }
        }
        
    }
        
    //選択された日に作成された日記を検索する
    func searchDiary() {
        //日記を検索する
    }
    
}
