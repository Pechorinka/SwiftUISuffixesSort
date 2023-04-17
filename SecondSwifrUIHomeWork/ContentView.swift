//
//  ContentView.swift
//  SecondSwifrUIHomeWork
//
//  Created by Tatyana Sidoryuk on 16.04.2023.
//

import SwiftUI

struct ContentView: View {

    @State private var viewIndex = 0
    @State public var text: String

    var views = ["Список", "Топ 10"]
    
    var body: some View {
        VStack {
            TextField("Введите текст", text: $text)
            
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Picker(selection: $viewIndex, label: Text("Выберите вид")) {
                ForEach(0..<2) { index in
                    Text(self.views[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .onChange(of: text) { newValue in
                    viewIndex = 2
                }

            if viewIndex == 0 {
                View1(text: $text)
            } else if viewIndex == 1 {
                View2(text: $text)
            } 
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .padding(.top)

    }
    
    struct View1: View {
        @Binding var text: String

        var body: some View {
            SuffixListView(text: $text)
        }
    }
    
    struct View2: View {
        @Binding var text: String

        var body: some View {
            TopListView(text: $text)
        }
    }
}
