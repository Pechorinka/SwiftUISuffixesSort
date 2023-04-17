//
//  SuffixSequence.swift
//  SecondSwifrUIHomeWork
//
//  Created by Tatyana Sidoryuk on 16.04.2023.
//

import Foundation

struct SuffixSequence: Sequence, IteratorProtocol {
    let word: String
    var offset: String.Index
    
    init(word: String) {
        self.word = word
        offset = word.endIndex
    }
    
    mutating func next() -> Substring? {
        guard offset > word.startIndex else { return nil }
        let current = offset
        offset = word.index(before: current)
        return word[current..<word.endIndex]
    }   
}

