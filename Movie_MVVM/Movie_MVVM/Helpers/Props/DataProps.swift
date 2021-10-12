// DataProps.swift
// Copyright © RoadMap. All rights reserved.

/// Пропс
enum DataProps<T> {
    case initial
    case success([T]?)
    case failure(String, String)
}
