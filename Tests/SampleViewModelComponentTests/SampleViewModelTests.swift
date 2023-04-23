//
//  SampleViewModelTests.swift
//  
//
//  Created by Igor Malyarov on 23.04.2023.
//

final class SampleViewModel: ObservableObject {
    
    @Published private(set) var text: String
    
    init(initialValue: String) {
        self.text = initialValue
    }
}

import XCTest

final class SampleViewModelTests: XCTestCase {
    
    func test_init_shouldSetInitialValue() {
        
        let (sut, spy) = makeSUT(initialValue: "abcd")
        
        XCTAssertEqual(spy.values, ["abcd"])
        XCTAssertNotNil(sut.text)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        initialValue: String
    ) -> (
        sut: SampleViewModel,
        spy: ValueSpy<String>
    ) {
        
        let sut = SampleViewModel(initialValue: initialValue)
        let spy = ValueSpy(sut.$text)
        
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(spy)
        
        return (sut, spy)
    }
}
