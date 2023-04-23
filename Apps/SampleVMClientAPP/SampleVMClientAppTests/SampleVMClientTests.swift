//
//  SampleVMClientTests.swift
//  SampleVMClientAppTests
//
//  Created by Igor Malyarov on 23.04.2023.
//

import Combine
import SampleViewModelComponent
@testable import SampleVMClientApp
import XCTest

final class SampleVMClientTests: XCTestCase {
    
    func test_shouldReplayValues() {
        
        let subject = PassthroughSubject<Int, Never>()
        let scheduler = DispatchQueue.test
        let sampleViewModel = SampleViewModel(
            initialValue: "ABC",
            publisher: subject.eraseToAnyPublisher(),
            scheduler: scheduler.eraseToAnyScheduler()
        )
        let sut = SampleVMClient(
            sampleViewModel: sampleViewModel,
            scheduler: scheduler.eraseToAnyScheduler()
        )
        
        let spy = ValueSpy(sut.$capitalisedText)
        
        subject.send(1)
        
        XCTAssertEqual(spy.values, [""])
        
        scheduler.advance()
        
        XCTAssertEqual(spy.values, ["", "Abc", "1"])
    }
}
