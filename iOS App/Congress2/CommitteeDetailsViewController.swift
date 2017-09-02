//
//  CommitteeDetailsViewController.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/26/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CommitteeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var committeeNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBAction func favorite_btn(_ sender: AnyObject) {
        if(isFavorite) {
            FavoriteData.sharedInstance.removeFavorCommittee(id: committeeID)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "empty_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(CommitteeDetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = false
        } else {
            FavoriteData.sharedInstance.addFavorCommittee(id: committeeID, name: committeeName)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filled_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(CommitteeDetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = true
        }
    }
    
    var committeeID: String?
    var committeeName: String?
    var isFavorite = false
    var detail_header = ["Committee ID", "Parent ID", "Chamber", "Office", "Contact"]
    var detail_content = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.detail_content = [String](repeating: "", count:self.detail_header.count)
        self.committeeNameLabel.text = committeeName
        //set favorite button by checking class favoritaData
        if(FavoriteData.sharedInstance.isFavorCommittee(id: committeeID)) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filled_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(CommitteeDetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = true
        }
        
        Alamofire.request("http://104.198.0.197:8080/committees?committee_id=\(self.committeeID!)").validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let jsonResults = json["results"].arrayValue
                self.detail_content[0] = jsonResults[0]["committee_id"].stringValue
                self.detail_content[1] = jsonResults[0]["parent_committee_id"].stringValue
                self.detail_content[2] = jsonResults[0]["chamber"].stringValue
                self.detail_content[3] = jsonResults[0]["office"].stringValue
                self.detail_content[4] = jsonResults[0]["phone"].stringValue
                //                print(self.detail_content)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detail_header.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommitteeDetailsCell") as! CommitteeDetailsTableViewCell
        
        cell.detailHeaderLabel.text = self.detail_header[indexPath.row]
        if(self.detail_content[indexPath.row] == "") {
            cell.detailContentLabel.text = "NA"
        } else {
            cell.detailContentLabel.text = self.detail_content[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
