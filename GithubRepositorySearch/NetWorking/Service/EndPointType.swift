//
//  EndPointType.swift
//  GithubRepositorySearch
//
//  Created by xiaoniu on 2021/07/06.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
