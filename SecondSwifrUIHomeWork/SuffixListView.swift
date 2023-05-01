//
//  SuffixListView.swift
//  SecondSwifrUIHomeWork
//
//  Created by Tatyana Sidoryuk on 16.04.2023.
//

import SwiftUI

struct SuffixListView: View {
    private let jobQueue = DispatchQueue(label: "SuffixListView.jobQueue", qos: .userInitiated)
    @Binding var text: String   
    @State private var suffixes: [String: Int] = [:]
    @State private var sortOrder: SortOrder = .alphabetical
    
    enum SortOrder {
        case alphabetical
        case reverseAlphabetical
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(suffixes.sorted(by: sortSuffixes), id: \.key) { suffix, count in
                    HStack {
                        Text(suffix)
                        Spacer()
                        Text("\(count)")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Divider()
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.sortOrder = self.sortOrder == .alphabetical ? .reverseAlphabetical : .alphabetical
                }) {
                    Text(sortOrder == .alphabetical ? "Сортировать по убыванию" : "Сортировать по возрастанию")
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
        }
        .padding()
        .onAppear {
            
            for word in text.split(whereSeparator: { !($0.isLetter) }) {
                let suffixSequence = SuffixSequence(word: String(word))
                
                
                jobQueue.async {

                    for suffix in suffixSequence {
                        if suffix.count > 0 {
                            DispatchQueue.main.async {
                                suffixes[String(suffix), default: 0] += 1
                            }
                        }
                    }
                }
            }
        }
    }
    
    func sortSuffixes(lhs: (key: String, value: Int), rhs: (key: String, value: Int)) -> Bool {
        switch sortOrder {
        case .alphabetical:
            return lhs.key < rhs.key
        case .reverseAlphabetical:
            return lhs.key > rhs.key
        }
    }
}

