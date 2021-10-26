// MovieViewModelTest.swift
// Copyright © ClickWatch. All rights reserved.

//
//  MovieViewModelTest.swift
//  MovieTests
//
//  Created by Maksim on 15.10.2021.
//
@testable import Movie_MVVM
import XCTest

final class MockMovieAPIService: MovieAPIServiceProtocol {
    var result: [Result] = []

    convenience init(result: [Result]) {
        self.init()
        self.result = result
    }

    func getMovieList(urlPath: String, completion: @escaping (Swift.Result<[Result], Error>) -> ()) {
        if result.isEmpty {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        } else {
            completion(.success(result))
        }
    }

    func getMovieDetails(movieID: Int?, completion: @escaping (Swift.Result<Details, Error>) -> ()) {}
}

final class MovieViewModelTest: XCTestCase {
    var mockAPIService: MockMovieAPIService!
    var viewModel: MovieViewModel!

    override func tearDownWithError() throws {
        mockAPIService = nil
    }

    func testGetMovieFromRequestSuccess() {
        let result = [Result()]
        mockAPIService = MockMovieAPIService(result: result)
        var catchResult: [Result] = []

        mockAPIService.getMovieList(urlPath: "") { result in
            switch result {
            case let .success(result):
                catchResult = result
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

        XCTAssertTrue(!catchResult.isEmpty)
    }

    func testGetMovieFromRequestFailure() {
        mockAPIService = MockMovieAPIService()
        var catchResult: [Result] = []
        mockAPIService.getMovieList(urlPath: "") { result in
            switch result {
            case let .success(result):
                catchResult = result
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        XCTAssertTrue(catchResult.isEmpty)
    }

    func testGetMoviesFromDatabase() {
        viewModel = MovieViewModel(movieAPIService: MovieAPIService(), repository: RealmRepository())
        viewModel.updateData(with: Int())
        let expectation = XCTestExpectation(description: "Test")
        viewModel.updateProps = { result in
            if case let .success(result) = result {
                XCTAssertNotNil(result)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 10)
    }
}
