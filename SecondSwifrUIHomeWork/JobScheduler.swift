//
//  JobScheduler.swift
//  SecondSwifrUIHomeWork
//
//  Created by Tatyana Sidoryuk on 01.05.2023.
//

import Foundation

class JobScheduler {
    private let operationQueue: OperationQueue

    init(maxConcurrentJobs: Int) {
        operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = maxConcurrentJobs
    }

    func addJob(_ job: @escaping () -> Void) {
        let operation = BlockOperation(block: job)
        operationQueue.addOperation(operation)
    }
}
