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
        _ = try makeSUT()
    }
    
    func test_viewDidLoad_setsBackgroundColor() throws {
        let sut = try makeSUT()
        
        let vcBackgroundColor = try XCTUnwrap(sut.view.backgroundColor, "ViewController background color is nil")
        
        let expectedViewControllerBackgroundColor = UIColor.white
        
        XCTAssertEqual(vcBackgroundColor.toHexString(), expectedViewControllerBackgroundColor.toHexString())
    }
    
    func test_viewDidLoad_configuresLineChartDelegate() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.lineChartView.delegate, "LineChart Delegate is nil")
    }
    
    private func makeSUT() throws -> ViewController {
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = storyboard.instantiateInitialViewController()
        let vc = try XCTUnwrap(initialVC)
        
        return try XCTUnwrap(vc as? ViewController)
    }
}
