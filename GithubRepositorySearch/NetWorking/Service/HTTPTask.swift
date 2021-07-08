//
//  HTTPTask.swift
//  GithubRepositorySearch
//
//  Created by xiaoniu on 2021/07/06.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
}
