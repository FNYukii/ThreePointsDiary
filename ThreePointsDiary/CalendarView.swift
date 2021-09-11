//
//  CalendarView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI
import FSCalendar
import UIKit

struct CalendarView: UIViewRepresentable{
    
    @Binding var selectedDate: Date
    
    func makeUIView(context: Context) -> UIView {
        //FSCalendarを生成
        typealias UIViewType = FSCalendar
        let fsCalendar = FSCalendar()
        fsCalendar.delegate = context.coordinator
        fsCalendar.dataSource = context.coordinator
        
        //基本スタイル
        fsCalendar.scrollDirection = .horizontal
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
    
    func makeCoordinator() -> Coordinator{
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent:CalendarView
        init(_ parent:CalendarView){
            self.parent = parent
        }
        //calendarメソッド
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
    }
    
}
