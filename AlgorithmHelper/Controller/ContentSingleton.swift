//
//  ContentSingleton.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-16.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import Foundation

class ContentSingleton {
    
    private var categoryList = [Category]()
    
    private static let contentSingletonInstance = ContentSingleton()
    
    static func instance() -> ContentSingleton {
        return contentSingletonInstance
    }
    
    func initializeData() {
        if let url = Bundle.main.url(forResource:"index", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let categories = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [[String: Any]]
                
                for category in categories {
                    let title = category["title"] as! String
                    let url = category["category"] as! String
                    var topicListFinal = [Topic]()
                    
                    let topicList = category["topics"] as! [[String: Any]]
                    for topic in topicList {
                        let title = topic["title"] as! String
                        let url = topic["topic"] as! String
                        let image = topic["image"] as! String
                        var articleListFinal = [Article]()
                            
                        let articleList = topic["articles"] as! [[String: Any]]
                        for article in articleList {
                            let title = article["title"] as! String
                            let url = article["article"] as! String
                            let description = article["description"] as! String
                            articleListFinal.append(Article(title: title, url: url, description: description, isBookmarked: false))
                        }
                        topicListFinal.append(Topic(title: title, url: url, image: image, articleList: articleListFinal))
                    }
                    categoryList.append(Category(title: title, url: url, topicList: topicListFinal))
                }
            } catch {
                print(error)
                print("Error: Problem serializing the index.plist file.")
            }
        } else {
            print("Error: File not found, cannot initialize ContentSingleton data.")
        }
    }
    
    func getCategoryList() -> [Category] {
        return categoryList
    }
}
