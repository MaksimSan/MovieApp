// MovieAPIServiceProtocol.swift
// Copyright © ClickWatch. All rights reserved.

protocol MovieAPIServiceProtocol: AnyObject {
    func getMovieList(urlPath: String, completion: @escaping (Swift.Result<[Result], Error>) -> ())
    func getMovieDetails(movieID: Int?, completion: @escaping (Swift.Result<Details, Error>) -> ())
}
