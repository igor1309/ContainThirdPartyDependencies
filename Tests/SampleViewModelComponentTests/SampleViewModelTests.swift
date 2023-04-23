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
        
        let sut = SampleViewModel(initialValue: "abcd")
        
        XCTAssertEqual(sut.text, "abcd")
    }
}
