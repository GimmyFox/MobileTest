//
//  NetworkError.swift
//  NewsFetcher
//
//  Created by Maksim Guzeev on 31.08.2023.
//

import Foundation

enum ApiClientError: Error {
    case request
    case network
    case empty
    case service(_ code: Int)
    case deserialize
}

