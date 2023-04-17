//
//  SuffixListView.swift
//  SecondSwifrUIHomeWork
//
//  Created by Tatyana Sidoryuk on 16.04.2023.
//

import SwiftUI

struct TopListView: View {
    @Binding var text: String
    @State private var suffixes: [String: Int] = [:]
    
    var body: some View {
        VStack {
            List {
                ForEach(suffixes.sorted(by: sortSuffixes).prefix(10), id: \.key) { suffix, count in
                    HStack {
                        Text(suffix)
                        Spacer()
                        Text("\(count)")
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Divider()

        }
        .padding()
        .onAppear {
            
            for word in text.split(whereSeparator: { !($0.isLetter) }) {
                let suffixSequence = SuffixSequence(word: String(word))
                
                for suffix in suffixSequence {
                    if suffix.count > 0 {
                        suffixes[String(suffix), default: 0] += 1
                    }
                }
            }
        }
    }
    
    func sortSuffixes(lhs: (key: String, value: Int), rhs: (key: String, value: Int)) -> Bool {
            return lhs.value > rhs.value
    }
}
