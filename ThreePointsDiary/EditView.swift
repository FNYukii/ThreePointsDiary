//
//  EditView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI
import RealmSwift

struct EditView: View {
    
    //この画面の環境変数
    @Environment(\.presentationMode) var presentation
    
    //その日のできごと
    @State var content01 = ""
    @State var content02 = ""
    @State var content03 = ""
    
    var body: some View {
        NavigationView {
            
            //日記入力フォーム
            Form {
                Section(header: Text("2021-09-10 The")){
                    TextField("できごとその1", text: $content01)
                    TextField("できごとその2", text: $content02)
                    TextField("できごとその3", text: $content03)
                }
            }
            
            //ナビゲーションバーの設定
            .navigationBarTitle("今日の日記", displayMode: .inline)
            .navigationBarItems(
                leading:Button("キャンセル"){
                    deleteDiary()
                    presentation.wrappedValue.dismiss()
                },
                trailing:Button("完了"){
                    saveDiary()
                    presentation.wrappedValue.dismiss()
                }
            )

        }
    }
    
    //日記の内容をデータベースに保存する
    func saveDiary() {
        
        //Realmをインスタンス化
        let realm = try! Realm()

        //Date型変数から詳細な情報を取り出すためのCalendarクラス
        let calendar = Calendar(identifier: .gregorian)
        
        //新規レコードのidを生成
        let maxId = realm.objects(Diary.self).sorted(byKeyPath: "id").last?.id ?? 0
        let newId = maxId + 1
        
        //新規レコードの日付テキストを生成
        let createdYear = calendar.component(.year, from: Date())
        let createdMonth = calendar.component(.month, from: Date())
        let createdDay = calendar.component(.day, from: Date())
        let weekDayNumber = calendar.component(.weekday, from: Date())
        var weekDayText = ""
        switch weekDayNumber {
        case 0:
            weekDayText = "日"
        case 1:
            weekDayText = "月"
        case 2:
            weekDayText = "火"
        case 3:
            weekDayText = "水"
        case 4:
            weekDayText = "木"
        case 5:
            weekDayText = "金"
        case 6:
            weekDayText = "土"
        default:
            weekDayText = "x"
        }
        let newCreatedDate = String(createdYear) + "年 " + String(createdMonth) + "月 " + String(createdDay) + "日 " + weekDayText
                
        //新規レコード作成
        let diary = Diary()
        diary.id = newId
        diary.createdDate = newCreatedDate
        diary.content01 = content01
        diary.content02 = content02
        diary.content03 = content03
        
        //新規レコード追加
        try! realm.write {
            realm.add(diary)
        }
        
    }
    
    //全ての日記を削除する
    func deleteDiary() {
        let realm = try! Realm()
        let results = realm.objects(Diary.self)
        try! realm.write {
            realm.delete(results)
        }
    }
    
}
