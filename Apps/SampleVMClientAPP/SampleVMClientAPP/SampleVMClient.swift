//
//  SampleVMClient.swift
//  SampleVMClientApp
//
//  Created by Igor Malyarov on 23.04.2023.
//

import SampleViewModelComponent
import Foundation

final class SampleVMClient: ObservableObject {
    
    @Published private(set) var capitalisedText: String = ""
    
    init(
        sampleViewModel: SampleViewModel,
        scheduler: AnySchedulerOfDispatchQueue = .makeMain()
    ) {
        
        sampleViewModel.$text
            .map { $0.capitalized }
            .receive(on: scheduler)
            .assign(to: &$capitalisedText)
    }
}
