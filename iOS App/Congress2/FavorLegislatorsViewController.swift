//
//  FavorLegislatorsViewController.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/27/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit

class FavorLegislatorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    @IBAction func search_btn(_ sender: AnyObject) {
        self.navigationItem.rightBarButtonItem = nil
        self.searchBarIsShown = true
        self.navigationItem.titleView = searchController.searchBar
    }
    
    var legislatorImages = [UIImage?]()
    var legislatorFirstNames = [String]()
    var legislatorLastNames = [String]()
    var legislatorStates = [String]()
    var legislatorBioID = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    var titleView : UIView?
    var searchBarIsShown = false
    var filteredFirstNames = [String]()
    var filteredLastNames = [String]()
    
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
        self.legislatorImages = FavoriteData.sharedInstance.legislatorImages
        self.legislatorFirstNames = FavoriteData.sharedInstance.legislatorFirstNames
        self.legislatorLastNames = FavoriteData.sharedInstance.legislatorLastNames
        self.legislatorStates = FavoriteData.sharedInstance.legislatorStates
        self.legislatorBioID = FavoriteData.sharedInstance.legislatorBioID
        
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
        self.filteredFirstNames = legislatorFirstNames.filter { firstName in
            return firstName.lowercased().contains(searchText.lowercased())
        }
        self.filteredLastNames = legislatorLastNames.filter { lastName in
            return lastName.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(FavorLegislatorsViewController.search_btn(_:)))
        self.searchBarIsShown = false
        self.navigationItem.titleView = self.titleView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legislatorFirstNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavorLegislatorCell", for: indexPath) as! FavorLegislatorCell
        
        let row = indexPath.row
        
        cell.legislatorImage.image = legislatorImages[row]
        cell.legislatorFirstNameLabel.text = legislatorFirstNames[row]
        cell.legislatorLastNameLabel.text = legislatorLastNames[row]
        cell.legislatorStateLabel.text = legislatorStates[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(!searchController.isActive) {
            return 50
        }
        if(searchController.searchBar.text == "") {
            return 50
        }
        
        let row = indexPath.row
        
        if(filteredFirstNames.contains(legislatorFirstNames[row])) {
            return 50
        }
        if(filteredLastNames.contains(legislatorLastNames[row])) {
            return 50
        }
        
        return 0
    }
    

    /// MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetails" {
            let detailsViewController = segue.destination as! DetailsViewController
            let row = self.tableView.indexPathForSelectedRow!.row
            // Setup new view controller
            
            detailsViewController.bioID = legislatorBioID[row]
            detailsViewController.image = legislatorImages[row]
        }
    }

}
