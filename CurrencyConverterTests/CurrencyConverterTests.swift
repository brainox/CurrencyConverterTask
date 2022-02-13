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
    
    // testing that the ViewController background color is blue
    func test_viewDidLoad_setsBackgroundColor() throws {
        let sut = try makeSUT()
        
        let vcBackgroundColor = try XCTUnwrap(sut.view.backgroundColor, "ViewController background color is nil")
        
        let expectedViewControllerBackgroundColor = UIColor.white
        
        XCTAssertEqual(vcBackgroundColor.toHexString(), expectedViewControllerBackgroundColor.toHexString())
    }
    
    // testing that the lineChartView delegate is the ViewController class
    func test_viewDidLoad_configuresLineChartDelegate() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.lineChartView.delegate, "LineChart Delegate is nil")
    }
    
    // testing that the initial state of the  convertedCurrencyTextField text is empty
    func test_viewDidLoad_convertedCurrencyTextFieldInitialState() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.convertedCurrencyTextField.text, "", "convertedCurrencyTextField is not nil")
    }
    
    func test_validCallToApiEndpoint() throws {
        
        let sut = try makeSUT()
        // given
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        //What we expect to happen
        let promise = expectation(description: "Status code: 200 or 201")
        
        let task = sut.viewModel.apiClass?.getData(completionHandler: { result in
            
        })
        
        sut.viewModel.apiClass?.getData(completionHandler: { result in
            switch result {
                
            case .success(let response):
//                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                    if statusCode == 200 || statusCode == 201 {
//                        print("Status code is 200")
//                    } else {
//                        print("")
//                    }
//                }
                print("")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        })
        
        
        
        // when
        //        let dataTask = sut.dataTask(with: url!) { data, response, error in
        //
        //            // then
        //            if let error = error {
        //                XCTFail("Error: \(error.localizedDescription)")
        //                return
        //            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
        //
        //                if statusCode == 200 || statusCode == 201 {
        //                    promise.fulfill()
        //                } else {
        //                    XCTFail("Status code: \(statusCode)")
        //                }
        //            }
        //        }
        //        dataTask.resume()
        
        //Keeps the test running until all expectations are fulfilled, or the timeout interval ends, whichever happens first
        wait(for: [promise], timeout: 5)
        
    }
    
    // extracting the initial process of loading the storyboard into a factory method
    private func makeSUT() throws -> ViewController {
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = storyboard.instantiateInitialViewController()
        let vc = try XCTUnwrap(initialVC)
        
        let sut = try XCTUnwrap(vc as? ViewController)
        sut.viewModel.apiClass = ApiManager(urlLink: "")
        
        return try XCTUnwrap(vc as? ViewController)
    }
    
    private class ApiManagerStub: ApiManager {
        override func getData(completionHandler: @escaping (Result<CurrencyModel, AFError>) -> Void) {
        
        }
    }
}
