//
//  CardCopyPicker.swift
//  Rivals
//
//  Created by Cody hancock on 3/26/24.
//

import SwiftUI

struct CardCopyPicker: View {
    
    @State private var selection = 0
    
    init() {
        // Set background color of picker
        UISegmentedControl.appearance().backgroundColor = .gray
        // Changes the color of the selected item
        UISegmentedControl.appearance().selectedSegmentTintColor = .selectedItem
        // Changes the text color for the selected item
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        // Changes the text color for the non-selected items
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        
        Picker("Select # of copies", selection: $selection) {
            Text("0").tag(0)
            Text("1").tag(1)
            Text("2").tag(2)
            Text("3").tag(3)
        }
        .frame(width: 200, height: 25)
        .pickerStyle(.segmented)
        
    }
}

#Preview {
    CardCopyPicker()
}
