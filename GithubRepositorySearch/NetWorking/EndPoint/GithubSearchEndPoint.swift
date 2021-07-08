//
//  GithubSearchEndPoint.swift
//  GithubRepositorySearch
//
//  Created by xiaoniu on 2021/07/06.
//

import Foundation

public enum GithubSearchApi {
    case searchGithubRepository(query: [String: Any])
}

extension GithubSearchApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .searchGithubRepository:
            return "/search/repositories"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .searchGithubRepository(let query):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: query)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
