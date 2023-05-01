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
    @State private var searchHistory: [String] = []

    var views = ["Список", "Топ 10", "История поиска"]
    let jobScheduler = JobScheduler(maxConcurrentJobs: 2)
    
    var body: some View {
        VStack {
            TextField("Введите текст", text: $text, onCommit: {
                if !text.isEmpty {
                    let job1: () -> Void = {
                        print("Job 1 started")
                        searchHistory.append(text)
                    }
                    jobScheduler.addJob(job1)
                    text = ""
                }
            })


                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Picker(selection: $viewIndex, label: Text("Выберите вид")) {
                ForEach(0..<3) { index in
                    Text(self.views[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
 

            if viewIndex == 0 {
                View1(text: $text)
            } else if viewIndex == 1 {
                View2(text: $text)
            } else if viewIndex == 2 {
                View3(story: $searchHistory)
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
    
    struct View3: View {
        @Binding var story: [String]

        var body: some View {
            SuffixHistoryView(searchHistory: $story)
        }
    }
}
