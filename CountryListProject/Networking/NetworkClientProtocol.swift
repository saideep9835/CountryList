//
//  NetworkClientProtocol.swift
//  CountryListProject
//
//  Created by Saideep Reddy Talusani on 4/18/25.
//


import Foundation

protocol NetworkClientProtocol {
    func genericFetch<T: Codable>(endPoint: String, parseType: T.Type) async throws -> T
    associatedtype NetworkErrors
}

final class NetworkClient: NetworkClientProtocol {
    func genericFetch<T: Decodable>(endPoint: String, parseType: T.Type) async throws -> T {
        guard let url = URL(string: endPoint) else {
            throw NetworkErrors.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkErrors.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(parseType, from: data)
            return decoded
        } catch {
            throw NetworkErrors.invalidData
        }
    }
    
    enum NetworkErrors: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
}
