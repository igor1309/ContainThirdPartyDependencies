//
//  AnySchedulerOfDispatchQueue.swift
//  
//
//  Created by Igor Malyarov on 23.04.2023.
//

import CombineSchedulers
import Foundation

public typealias AnySchedulerOfDispatchQueue = AnySchedulerOf<DispatchQueue>

public extension AnySchedulerOfDispatchQueue {
    
    static func makeMain() -> Self { .main }
}
