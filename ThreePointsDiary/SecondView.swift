//
//  SecondView.swift
//  ThreePointsDiary
//
//  Created by Yu on 2021/09/10.
//

import SwiftUI

struct SecondView: View{
    var body: some View {
        
        Form {
            Section {
                CalendarView()
                    .frame(height: 400)
            }
            Section {
                Text("Apple")
                Text("Orange")
                Text("Strawberry")
            }
        }
        
    }
}
