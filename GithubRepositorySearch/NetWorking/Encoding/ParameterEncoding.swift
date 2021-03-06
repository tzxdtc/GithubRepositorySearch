//
//  ParameterEncoding.swift
//  GithubRepositorySearch
//
//  Created by xiaoniu on 2021/07/06.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    case urlEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
            }
        }catch {
            throw error
        }
    }
}


public enum NetworkError : String, Error {
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
