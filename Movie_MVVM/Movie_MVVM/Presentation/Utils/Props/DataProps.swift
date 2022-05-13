// DataProps.swift
// Copyright © ClickWatch. All rights reserved.

enum DataProps<T> {
    case loading
    case success([T]?)
    case failure(String, String)
}
