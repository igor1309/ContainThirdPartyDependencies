//
//  SampleViewModelTests.swift
//  
//
//  Created by Igor Malyarov on 23.04.2023.
//

import Combine

final class SampleViewModel: ObservableObject {
    
    @Published private(set) var text: String
    
    init(
        initialValue: String,
        publisher: AnyPublisher<Int, Never>
    ) {
        self.text = initialValue
        
        publisher
            .map(String.init)
            .receive(on: DispatchQueue.main)
            .assign(to: &$text)
    }
}

import XCTest

final class SampleViewModelTests: XCTestCase {
    
    func test_init_shouldSetInitialValue() {
        
        let (sut, spy, _) = makeSUT(initialValue: "abcd")
        
        XCTAssertEqual(spy.values, ["abcd"])
        XCTAssertNotNil(sut.text)
    }
    
    func test_shouldPublishStrings() {
        
        let (sut, spy, subject) = makeSUT(initialValue: "abcd")
        
        subject.send(1)
        _ = XCTWaiter().wait(for: [.init()], timeout: 0.1)
        
        XCTAssertEqual(spy.values, ["abcd", "1"])
        XCTAssertNotNil(sut.text)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        initialValue: String
    ) -> (
        sut: SampleViewModel,
        spy: ValueSpy<String>,
        subject: PassthroughSubject<Int, Never>
    ) {
        
        let subject = PassthroughSubject<Int, Never>()
        let sut = SampleViewModel(
            initialValue: initialValue,
            publisher: subject.eraseToAnyPublisher()
        )
        let spy = ValueSpy(sut.$text)
        
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(spy)
        trackForMemoryLeaks(subject)
        
        return (sut, spy, subject)
    }
}
