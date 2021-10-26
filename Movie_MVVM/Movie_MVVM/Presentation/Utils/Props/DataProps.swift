// DataProps.swift
// Copyright © ClickWatch. All rights reserved.

/// Пропс
enum DataProps<T> {
    case loading
    case success([T]?)
    case failure(String, String)
}
