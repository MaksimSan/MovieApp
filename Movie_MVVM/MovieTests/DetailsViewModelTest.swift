// DetailsViewModelTest.swift
// Copyright © ClickWatch. All rights reserved.

//
//  MovieViewModelTest.swift
//  MovieTests
//
//  Created by Maksim on 15.10.2021.
//
@testable import Movie_MVVM
import XCTest

final class MockDetailsMovieAPIService: MovieAPIServiceProtocol {
    var details: Details?

    convenience init(details: Details?) {
        self.init()
        self.details = details
    }

    func getMovieList(urlPath: String, completion: @escaping (Swift.Result<[Result], Error>) -> ()) {}

    func getMovieDetails(movieID: Int?, completion: @escaping (Swift.Result<Details, Error>) -> ()) {
        if details == nil {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        } else {
            guard let details = details else { return }
            completion(.success(details))
        }
    }
}

final class DetailsMovieViewModelTest: XCTestCase {
    var mockAPIService: MockDetailsMovieAPIService!

    override func tearDownWithError() throws {
        mockAPIService = nil
    }

    func testGetMovieFromRequestSuccess() {
        let details = Details()
        mockAPIService = MockDetailsMovieAPIService(details: details)
        var catchDetails: Details?

        mockAPIService.getMovieDetails(movieID: Int()) { result in
            switch result {
            case let .success(details):
                catchDetails = details
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

        XCTAssertNotNil(catchDetails)
    }

    func testGetMovieFromRequestFailure() {
        mockAPIService = MockDetailsMovieAPIService()
        var catchDetails: Details?
        mockAPIService.getMovieDetails(movieID: Int()) { result in
            switch result {
            case let .success(details):
                catchDetails = details
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

        XCTAssertNil(catchDetails)
    }
}
