//
//  GithubSearchResponse.swift
//  GithubRepositorySearch
//
//  Created by xiaoniu on 2021/07/07.
//

import Foundation

struct GithubSearchResponse {
    let githubRepositories: [GithubSearchRepository]
}

extension GithubSearchResponse: Decodable {
    
    private enum GithubSearchResponseCodingKeys: String, CodingKey {
        case githubRepositories = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GithubSearchResponseCodingKeys.self)
        githubRepositories = try container.decode([GithubSearchRepository].self, forKey: .githubRepositories)
    }
}


struct GithubSearchRepository {
    let repositoryName: String
    let url: String
    let star: Int
}

extension GithubSearchRepository: Decodable {
    
    enum RepositoryCodingKeys: String, CodingKey {
        case repositoryName = "full_name"
        case url = "html_url"
        case star = "watchers"
    }
    
    init(from decoder: Decoder) throws {
        let githubRepositoryContainer = try decoder.container(keyedBy: RepositoryCodingKeys.self)
        
        repositoryName = try githubRepositoryContainer.decode(String.self, forKey: .repositoryName)
        url = try githubRepositoryContainer.decode(String.self, forKey: .url)
        star = try githubRepositoryContainer.decode(Int.self, forKey: .star)
    }
}
