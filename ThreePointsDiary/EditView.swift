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
    
    var body: some View {
        NavigationView {
            
            Text("このSheetで日記を編集する")
            
                .navigationBarTitle("今日の日記", displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button("キャンセル"){
                        presentation.wrappedValue.dismiss()
                    },
                    trailing:
                    Button("完了"){
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
