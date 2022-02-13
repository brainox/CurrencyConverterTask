//
//  ViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Decagon on 12/02/2022.
//

import XCTest
@testable import CurrencyConverter

class CurrencyViewModelTests: XCTestCase {
    
    var sut: CurrencyViewModel?
    
    override func setUp() {
        super.setUp()
        sut = CurrencyViewModel(apiString: "")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    
}
