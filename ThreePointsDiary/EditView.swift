//
//  EditView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI

struct EditView: View {
    
    //この画面の環境変数
    @Environment(\.presentationMode) var presentation
    
    //その日のできごと
    @State var point01 = ""
    @State var point02 = ""
    @State var point03 = ""
    
    var body: some View {
        NavigationView {
            
            //日記入力フォーム
            Form {
                Section(header: Text("2021-09-10 The")){
                    TextField("できごとその1", text: $point01)
                    TextField("できごとその2", text: $point02)
                    TextField("できごとその3", text: $point03)
                }
            }
            
            //ナビゲーションバーの設定
            .navigationBarTitle("今日の日記", displayMode: .inline)
            .navigationBarItems(
                leading:Button("キャンセル"){
                    presentation.wrappedValue.dismiss()
                },
                trailing:Button("完了"){
                    saveDiary()
                    presentation.wrappedValue.dismiss()
                }
            )

        }
    }
    
    func saveDiary() {
        //日記の内容をデータベースに保存する
    }
    
}
