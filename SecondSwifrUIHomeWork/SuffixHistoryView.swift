//
//  SuffixHistory.swift
//  SecondSwifrUIHomeWork
//
//  Created by Tatyana Sidoryuk on 01.05.2023.
//

import Foundation
import SwiftUI

struct SuffixHistoryView: View {
    @Binding var searchHistory: [String]

    var body: some View {
        List(searchHistory, id: \.self) { searchText in
            Text(searchText)
        }
        .navigationTitle("История поиска")
    }
}
