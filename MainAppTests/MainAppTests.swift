//
//  MainAppTests.swift
//  MainAppTests
//
//  Created by Senthil Kumar R on 04/09/24.
//

import XCTest
@testable import MainApp
import FindMyIP
import Combine

final class MainAppTests: XCTestCase {
    var viewModel: ViewModel!
    var cancellabel: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModel(service: NetworkService())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        let expectaion = expectation(description: "Fetch my Ip")
        self.viewModel.getMYIPDetailsAF()
        self.viewModel.$isLoad
            .dropFirst()
            .sink { load in
                XCTAssertFalse(load)
                expectaion.fulfill()
            }
            .store(in: &cancellabel)
        wait(for: [expectaion], timeout: 1.0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
