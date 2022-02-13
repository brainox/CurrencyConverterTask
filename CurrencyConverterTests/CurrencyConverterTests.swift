//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Decagon on 12/02/2022.
//

import XCTest
@testable import CurrencyConverter

class ViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }

    override func tearDown() {

        super.tearDown()
    }
    
    // testing that the initial view controller is ViewController
    func test_canInit() throws {
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)

        let initialVC = storyboard.instantiateInitialViewController()
        let vc = try XCTUnwrap(initialVC as? UIViewController)
        
        _ = try XCTAssert(vc is ViewController)
    }
    
    func test_viewDidLoad_setsBackgroundColor() throws {
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)

        let initialVC = storyboard.instantiateInitialViewController()
        let vc = try XCTUnwrap(initialVC as? UIViewController)
        
        let sut = try XCTUnwrap(vc as? ViewController)
        
        let vcBackgroundColor = try XCTUnwrap(sut.view.backgroundColor, "ViewController background color is nil")
        
        let expectedViewControllerBackgroundColor = UIColor.white
        
        XCTAssertEqual(vcBackgroundColor.toHexString(), expectedViewControllerBackgroundColor.toHexString())
    }
}
