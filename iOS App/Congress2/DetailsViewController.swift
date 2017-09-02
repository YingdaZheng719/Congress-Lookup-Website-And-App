//
//  DetailsViewController.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/23/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON


class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBAction func favorite_btn(_ sender: AnyObject) {
        if(isFavorite) {
            FavoriteData.sharedInstance.removeFavorLegis(bioID: bioID!)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "empty_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = false
        } else {
            FavoriteData.sharedInstance.addFavorLegis(image: image, firstName: detail_content[0], lastName: detail_content[1], state: detail_content[2], id: bioID)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filled_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = true
        }
    }
    
    var bioID: String?
    var image: UIImage?
    var isFavorite = false
    var detail_header = ["First Name", "Last Name", "State", "Birth date", "Gender", "Chamber", "Fax No.", "Twitter", "Website", "Office", "End Term"]
    var detail_content = [String]()
    let cellReuseIdentifier = "details_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.detail_content = [String](repeating: "", count:self.detail_header.count)
        self.imageView.image = image
        //set favorite button by checking class favoritaData
        if(FavoriteData.sharedInstance.isFavorLegis(bioID: bioID)) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filled_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = true
        }
        
        
        Alamofire.request("http://104.198.0.197:8080/legislators?bioguide_id=\(self.bioID!)").validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //                print("JSON: \(json)")
                let jsonResults = json["results"].arrayValue
                self.detail_content[0] = jsonResults[0]["first_name"].stringValue
                self.detail_content[1] = jsonResults[0]["last_name"].stringValue
                self.detail_content[2] = jsonResults[0]["state_name"].stringValue
                self.detail_content[3] = jsonResults[0]["birthday"].stringValue
                self.detail_content[4] = jsonResults[0]["gender"].stringValue
                self.detail_content[5] = jsonResults[0]["chamber"].stringValue
                self.detail_content[6] = jsonResults[0]["fax"].stringValue
                self.detail_content[7] = "https://twitter.com/" + jsonResults[0]["twitter_id"].stringValue
                self.detail_content[8] = jsonResults[0]["website"].stringValue
                self.detail_content[9] = jsonResults[0]["office"].stringValue
                self.detail_content[10] = jsonResults[0]["term_end"].stringValue
                //                print(self.legislatorFirstNames)
                //                print(self.legislatorLastNames)
                //                print(self.legislatorStates)
//                print(self.detail_content)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        tableView.estimatedRowHeight = 50
        
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
        let cell:DetailsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! DetailsTableViewCell
        
        cell.detailHeaderLabel.text = self.detail_header[indexPath.row]
        if(self.detail_content[indexPath.row] == "") {
            cell.detailContentLabel.text = "NA"
            return cell
        }
        if(self.detail_header[indexPath.row] == "Twitter") {
            cell.detailContentLabel.text = "Twitter Link"
            cell.detailContentLabel.textColor = UIColor.blue
            let tap = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.openTwitter))
            cell.detailContentLabel.isUserInteractionEnabled = true
            cell.detailContentLabel.addGestureRecognizer(tap)
        } else if(self.detail_header[indexPath.row] == "Website") {
            cell.detailContentLabel.text = "Website Link"
            cell.detailContentLabel.textColor = UIColor.blue
            let tap = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.openWebsite))
            cell.detailContentLabel.isUserInteractionEnabled = true
            cell.detailContentLabel.addGestureRecognizer(tap)
        } else {
            cell.detailContentLabel.text = self.detail_content[indexPath.row]
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func openTwitter(sender:UITapGestureRecognizer) {
        open(scheme: self.detail_content[7])
    }
    
    func openWebsite(sender:UITapGestureRecognizer) {
        open(scheme: self.detail_content[8])
    }
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
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
