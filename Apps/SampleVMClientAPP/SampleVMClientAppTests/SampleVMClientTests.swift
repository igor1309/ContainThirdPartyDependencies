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
        let (sut, spy) = makeSUT(
            subject: subject,
            scheduler: scheduler.eraseToAnyScheduler()
        )
        
        subject.send(1)
        
        XCTAssertEqual(spy.values, [""])
        
        scheduler.advance()
        
        XCTAssertEqual(spy.values, ["", "Abc", "1"])
        XCTAssertNotNil(sut)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        initialValue: String = "ABC",
        subject: PassthroughSubject<Int, Never>,
        scheduler: AnySchedulerOfDispatchQueue
    ) -> (
        sut: SampleVMClient,
        spy: ValueSpy<String>
    ) {
        
        let sampleViewModel = SampleViewModel(
            initialValue: initialValue,
            publisher: subject.eraseToAnyPublisher(),
            scheduler: scheduler.eraseToAnyScheduler()
        )
        let sut = SampleVMClient(
            sampleViewModel: sampleViewModel,
            scheduler: scheduler.eraseToAnyScheduler()
        )
        let spy = ValueSpy(sut.$capitalisedText)
        
        
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(spy)
        
        return (sut, spy)
    }
}
