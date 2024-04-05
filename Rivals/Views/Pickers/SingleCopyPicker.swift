//
//  SingleCopyPicker.swift
//  Rivals
//
//  Created by Cody hancock on 3/26/24.
//

import SwiftUI

struct SingleCopyPicker: View {
    
    @State private var selection = 0
    
    
    init() {
        // Set background color of picker
        UISegmentedControl.appearance().backgroundColor = .gray.withAlphaComponent(0.15)
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
        }
        .frame(width:100, height: 25)
        .pickerStyle(.segmented)
    }
}

#Preview {
    SingleCopyPicker()
}
