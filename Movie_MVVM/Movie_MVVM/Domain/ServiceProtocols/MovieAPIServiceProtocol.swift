// MovieAPIServiceProtocol.swift
// Copyright © ClickWatch. All rights reserved.

protocol MovieAPIServiceProtocol: AnyObject {
    func getMovieList(urlPath: String, completion: @escaping (Result<[FilmObject], Error>) -> Void)
    func getMovieDetails(movieID: Int?, completion: @escaping (Result<Details, Error>) -> Void)
}
