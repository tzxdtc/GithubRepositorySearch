//
//  RepositoryResultTableViewCell.swift
//  GithubRepositorySearch
//
//  Created by xiaoniu on 2021/07/05.
//

import UIKit

class RepositoryResultTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositoryStarCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(repository: GithubSearchRepository) {
        repositoryName.text = repository.repositoryName
//        repositoryDescription.text = repository.repositoryDescription
        repositoryStarCount.text = String(repository.star)
    }
}
