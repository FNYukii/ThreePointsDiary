//
//  SecondView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI

struct SecondView: View{
    
    //カレンダー上で選択された日付
    @State var selectedDate = Date()
    
    var body: some View {
        
        Form {
            Section {
                CalendarView(selectedDate: $selectedDate)
                    .frame(height: 400)
            }
            Section(header: Text("\(ymdText(inputDate: selectedDate)) \(weekdayText(inputDate: selectedDate))")) {
                Text("Apple")
                Text("Orange")
                Text("Strawberry")
            }
            
        }
        
    }
    
    //Date型変数を年月日のみの文字列に変換する
    func ymdText(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy年 M月 d日"
        return dateFormatter.string(from: inputDate)
    }
    
    //Date型変数を曜日のみの文字列に変換する
    func weekdayText(inputDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let weekdayNumber = calendar.component(.weekday, from: inputDate)
        let weekdaySymbolIndex: Int = weekdayNumber - 1
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja") as Locale
        return formatter.shortWeekdaySymbols[weekdaySymbolIndex]
    }
    
}
