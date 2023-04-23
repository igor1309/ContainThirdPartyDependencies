//
//  SampleViewModelTests.swift
//  
//
//  Created by Igor Malyarov on 23.04.2023.
//

import Combine
import CombineSchedulers

final class SampleViewModel: ObservableObject {
    
    @Published private(set) var text: String
    
    init(
        initialValue: String,
        publisher: AnyPublisher<Int, Never>,
        scheduler: AnySchedulerOf<DispatchQueue> = .main
    ) {
        self.text = initialValue
        
        publisher
            .map(String.init)
            .receive(on: scheduler)
            .assign(to: &$text)
    }
}

import XCTest

final class SampleViewModelTests: XCTestCase {
    
    func test_shouldPublishStrings() {
        
        let scheduler = DispatchQueue.test
        let (sut, spy, subject) = makeSUT(
            initialValue: "abcd",
            scheduler: scheduler.eraseToAnyScheduler()
        )
        
        subject.send(1)
        
        XCTAssertEqual(spy.values, ["abcd"])
        
        scheduler.advance()

        XCTAssertEqual(spy.values, ["abcd", "1"])
        XCTAssertNotNil(sut.text)
    }
    
    func test_shouldPublishStrings_onImmediate() {
        
        let scheduler = DispatchQueue.immediate
        let (sut, spy, subject) = makeSUT(
            initialValue: "abcd",
            scheduler: scheduler.eraseToAnyScheduler()
        )
        
        subject.send(1)
        
        XCTAssertEqual(spy.values, ["abcd", "1"])
        XCTAssertNotNil(sut.text)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        initialValue: String,
        scheduler: AnySchedulerOf<DispatchQueue>
    ) -> (
        sut: SampleViewModel,
        spy: ValueSpy<String>,
        subject: PassthroughSubject<Int, Never>
    ) {
        
        let subject = PassthroughSubject<Int, Never>()
        let sut = SampleViewModel(
            initialValue: initialValue,
            publisher: subject.eraseToAnyPublisher(),
            scheduler: scheduler
        )
        let spy = ValueSpy(sut.$text)
        
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(spy)
        trackForMemoryLeaks(subject)
        
        return (sut, spy, subject)
    }
}
