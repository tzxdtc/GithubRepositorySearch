//
//  ViewController.swift
//  GithubRepositorySearch
//
//  Created by xiaoniu on 2021/07/05.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var repositoryResultsTableView: UITableView!
    @IBOutlet var indicatorView: UIView!
    
    var webView: WKWebView!
    let networkManager = NetworkManager()
    var debounce_timer: Timer?
    var githubSearchRepositories: [GithubSearchRepository] = []
    var searchText: String = ""
    let perPage = 30
    
    var isDataLoaded = false
    
    // all data loaded flag
    var isDataEnded = false {
        didSet {
            DispatchQueue.main.async {
                if self.isDataEnded {
                    let view = UIView()
                    view.backgroundColor = UIColor.black
                    self.repositoryResultsTableView.tableFooterView = view
                } else {
                    self.indicatorView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44)
                    self.repositoryResultsTableView.tableFooterView = self.indicatorView
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoryResultsTableView.delegate = self
        repositoryResultsTableView.dataSource = self
        repositoryResultsTableView.keyboardDismissMode = .onDrag
        repositoryResultsTableView.register(UINib(nibName: "RepositoryResultTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryResultTableViewCell")
        searchField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func configureTableView() {
        // add line to top of tableview
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: self.repositoryResultsTableView.frame.size.width, height: px)
        let line = UIView(frame: frame)
        line.backgroundColor = UIColor.lightGray
        self.repositoryResultsTableView.tableHeaderView = line
        
        // add separator
        repositoryResultsTableView.separatorStyle = .singleLine
        repositoryResultsTableView.separatorColor = UIColor.lightGray
    }
    
    func loadGithubRepositories() {
        if isDataEnded { return }
        
        let page = self.githubSearchRepositories.count/self.perPage
        let query = ["q": self.searchText, "page": page] as [String: Any]
        
        networkManager.getGithubRepository(query: query) { githubSearchRepository, error in
            if error != nil {
                return
            }
            
            guard let githubSearchRepositories = githubSearchRepository else { return }
            self.githubSearchRepositories.append(contentsOf: githubSearchRepositories)
            self.isDataLoaded = true
            DispatchQueue.main.async {
                self.repositoryResultsTableView.reloadData()
            }
            self.isDataEnded = self.githubSearchRepositories.count < self.perPage
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        // incremental search
        debounce_timer?.invalidate()
        debounce_timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            if let searchText = textField.text, searchText != "" {
                self.searchText = searchText
                self.loadGithubRepositories()
            } else {
                self.githubSearchRepositories = []
                self.repositoryResultsTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubSearchRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryResultTableViewCell") as! RepositoryResultTableViewCell
        cell.configure(repository: githubSearchRepositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WebViewViewController()
        vc.urlString = githubSearchRepositories[indexPath.row].url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // load data when scroll to bottom
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isDataLoaded && isDataEnded == false {
            if indexPath.row >= (githubSearchRepositories.count - 2) {
                self.loadGithubRepositories()
            }
        }
    }
}

