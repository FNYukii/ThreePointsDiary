//
//  CalendarView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable{
    
    func makeUIView(context: Context) -> UIView {
        //FSCalendarを生成
        typealias UIViewType = FSCalendar
        let fsCalendar = FSCalendar()
        //ヘッダーのスタイル
        fsCalendar.appearance.headerTitleColor = UIColor.label
        fsCalendar.appearance.headerDateFormat = "yyyy年 M月"
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0
        fsCalendar.appearance.weekdayTextColor = UIColor.secondaryLabel
        //日付のスタイル
        fsCalendar.appearance.titleDefaultColor = UIColor.label
        //本日のスタイル
        fsCalendar.appearance.todayColor = .clear
        fsCalendar.appearance.titleTodayColor = .red
        //選択日のスタイル
        fsCalendar.appearance.selectionColor = UIColor.secondaryLabel
        fsCalendar.appearance.borderSelectionColor = .clear
        fsCalendar.appearance.titleSelectionColor = .white
        
        
        return fsCalendar
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //do nothing
    }
    
}
