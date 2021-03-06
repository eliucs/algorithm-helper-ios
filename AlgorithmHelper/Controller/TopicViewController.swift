//
//  TopicViewController.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categoryIndex: Int = 0
    var topicIndex: Int = 0
    var topicTitle: String = ""
    var numRows: Int = 0
    var articleIndexSelected: Int = 0
    
    @IBOutlet weak var articleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTableView.delegate = self
        articleTableView.dataSource = self
        topicTitle = Content.instance().getCategoryList()[categoryIndex].topicList[topicIndex].title
        numRows = Content.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList.count
        self.navigationItem.title = topicTitle
    }
    
    // MARK: - Configure articleTableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows
    }
    
    // MARK: - Populate articleTableView cells with corresponding article titles
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.articleLabel.text = Content.instance().getCategoryList()[categoryIndex].topicList[topicIndex].articleList[indexPath.row].title
        return cell
    }
    
    // MARK: - Prepare for seugue to ArticleViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let dest = segue.destination as! ArticleViewController
        dest.categoryIndex = categoryIndex
        dest.topicIndex = topicIndex
        dest.articleIndex = articleIndexSelected
    }
    
    // MARK: - Perform segue to ArticleViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        articleIndexSelected = indexPath.row
        performSegue(withIdentifier: "goToArticleView", sender: self)
    }
}
