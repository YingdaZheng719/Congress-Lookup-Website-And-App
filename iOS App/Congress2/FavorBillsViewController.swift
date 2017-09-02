//
//  FavorBillsViewController.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/27/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit

class FavorBillsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    @IBAction func search_btn(_ sender: AnyObject) {
        self.navigationItem.rightBarButtonItem = nil
        self.searchBarIsShown = true
        self.navigationItem.titleView = searchController.searchBar
    }
    
    var billID = [String]()
    var billOfficialTitle = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    var titleView : UIView?
    var searchBarIsShown = false
    var filteredTitle = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        titleView = self.navigationItem.titleView
        self.setNavigationBarItem()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.showsCancelButton = true
        self.definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //retrive data from FavoriteData
        self.billID = FavoriteData.sharedInstance.billID
        self.billOfficialTitle = FavoriteData.sharedInstance.billOfficialTitle
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredTitle = billOfficialTitle.filter { title in
            return title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(FavorBillsViewController.search_btn(_:)))
        self.searchBarIsShown = false
        self.navigationItem.titleView = self.titleView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavorBillCell", for: indexPath) as! FavorBillCell
        
        let row = indexPath.row
        
        cell.billContentLabel.text = billOfficialTitle[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(!searchController.isActive) {
            return 120
        }
        if(searchController.searchBar.text == "") {
            return 120
        }
        
        let row = indexPath.row
        
        if(filteredTitle.contains(billOfficialTitle[row])) {
            return 120
        }
        
        return 0
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetails" {
            let detailsViewController = segue.destination as! BillDetailsViewController
            let row = self.tableView.indexPathForSelectedRow!.row
            // Setup new view controller
            
            detailsViewController.billID = billID[row]
            detailsViewController.officialTitle = billOfficialTitle[row]
        }
    }

}
