//
//  Schedulers.swift
//  
//
//  Created by Igor Malyarov on 23.04.2023.
//

import CombineSchedulers
import XCTest

extension XCTestCase {
    
    func makeTestScheduler() -> TestSchedulerOf<DispatchQueue> {
        
        DispatchQueue.test
    }
    
    func makeImmediateScheduler() -> ImmediateSchedulerOf<DispatchQueue> {
        
        DispatchQueue.immediate
    }
}
