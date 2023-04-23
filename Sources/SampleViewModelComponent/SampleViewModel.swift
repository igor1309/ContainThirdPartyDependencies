//
//  SampleViewModel.swift
//  
//
//  Created by Igor Malyarov on 23.04.2023.
//

import Combine
import Foundation

public final class SampleViewModel: ObservableObject {
    
    @Published public private(set) var text: String
    
    public init(
        initialValue: String,
        publisher: AnyPublisher<Int, Never>,
        scheduler: AnySchedulerOfDispatchQueue = .makeMain()
    ) {
        self.text = initialValue
        
        publisher
            .map(String.init)
            .receive(on: scheduler)
            .assign(to: &$text)
    }
}
