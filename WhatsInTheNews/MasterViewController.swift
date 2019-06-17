//
//  MasterViewController.swift
//  WhatsInTheNews
//
//  Created by Jeremy Van on 2/15/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit


class MasterViewController: UITableViewController, UISearchBarDelegate {
    let searchBar = UISearchBar()
    var newsItems: [NewsItem] = []
    let newsService = NewsService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.preferredDisplayMode = .allVisible
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        search()
    }
    
    func search(for term: String? = nil) {
        newsService.search(for: term ?? "apple", completion: { news, error in
            guard let news = news, error == nil else {
                let alertController = UIAlertController(title: "Oops!", message: "Please check network connection.", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Dismiss", style: .default)
                alertController.addAction(action1)
                print(error ?? "unknown error")
                self.present(alertController, animated: true, completion: nil)
                return
            }
            if news.count == 0 {
                self.newsItems = news
                let alertController = UIAlertController(title: "Term not found", message: "Please try another search term.", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Dismiss", style: .default)
                alertController.addAction(action1)
                print(error ?? "unknown error")
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.newsItems = news
            }
            self.tableView.reloadData()
        })
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // use searchBar.text as term argument, passed into search function
        search(for: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // requires to dismiss keyboard in order to execute search
        searchBar.resignFirstResponder()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell()
        }
        
        // Configure the cell...
        let news = newsItems[indexPath.row]
        cell.newsTitleLabel.text = news.title
        cell.newsAuthorLabel.text = news.author
        cell.newsRecentLabel.isHidden = !news.isRecent
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        guard let selectedTableViewCell = sender as? NewsTableViewCell else { return }
        guard let selectedIndexPath = tableView.indexPath(for: selectedTableViewCell) else { return }
        
        let news = newsItems[selectedIndexPath.row]
        detailViewController.news = news
    }

}
