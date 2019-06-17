//
//  NewsItem.swift
//  WhatsInTheNews
//
//  Created by Jeremy Van on 2/15/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit

struct NewsResult: Codable {
    let articles: [NewsItem]
}


struct NewsItem: Codable {
    let source: SourceName?
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
}

struct SourceName: Codable {
    let name: String?
}

extension NewsItem {
    var isRecent: Bool {
        guard let publishedAt = publishedAt else {return false}
        
        //2019-02-17T18:00:55Z
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let newsDate = dateFormatter.date(from: publishedAt) else {
            return false
        }
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let articleMonth = calendar.component(.month, from: newsDate)
        
        return month == articleMonth
    }
}

