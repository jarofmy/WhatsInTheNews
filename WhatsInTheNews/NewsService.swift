//
//  NewsService.swift
//  WhatsInTheNews
//
//  Created by Jeremy Van on 2/15/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit

class NewsService {
    
    var dataTask: URLSessionDataTask?
    
    private let urlString = "https://newsapi.org/v2/everything?q="
    private let apiKey = "&apiKey=1503b6b693024e27b6e8a104b296279e"

    
    func search(for searchTerm: String, completion: @escaping ([NewsItem]?, Error?) -> ()) {
        
        let searchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: urlString + searchTerm + apiKey) else {
            print("invalid url: \(urlString + searchTerm)")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            print("Status code: \(response.statusCode)")
            print(String(data: data, encoding: .utf8) ?? "unable to print data")
            
            do {
                let decoder = JSONDecoder()
                let newsResult = try decoder.decode(NewsResult.self, from: data)
                DispatchQueue.main.async { completion(newsResult.articles, nil) }
            } catch (let error) {
                
                DispatchQueue.main.async { completion(nil, error) }
                
            }
        }
        task.resume()
    }
}

