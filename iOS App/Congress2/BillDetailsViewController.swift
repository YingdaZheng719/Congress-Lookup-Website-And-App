//
//  BillDetailsViewController.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/25/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BillDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBAction func favorite_btn(_ sender: AnyObject) {
        if(isFavorite) {
            FavoriteData.sharedInstance.removeFavorBill(id: billID)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "empty_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BillDetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = false
        } else {
            FavoriteData.sharedInstance.addFavorBill(id: billID, title: officialTitle)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filled_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BillDetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = true
        }
    }
    
    var billID: String?
    var officialTitle: String?
    var isFavorite = false
    var detail_header = ["Bill ID", "Bill Type", "Sponsor", "Last Action", "PDF", "Chamber", "Last Vote", "Status"]
    var detail_content = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.detail_content = [String](repeating: "", count:self.detail_header.count)
        self.titleLabel.text = officialTitle
        //set favorite button by checking class favoritaData
        if(FavoriteData.sharedInstance.isFavorBill(id: billID)) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filled_star"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BillDetailsViewController.favorite_btn(_:)))
            self.navigationItem.rightBarButtonItem?.imageInsets.top = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.bottom = 15
            self.navigationItem.rightBarButtonItem?.imageInsets.left = 25
            isFavorite = true
        }

        Alamofire.request("http://104.198.0.197:8080/bills?bill_id=\(self.billID!)").validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let jsonResults = json["results"].arrayValue
                self.detail_content[0] = jsonResults[0]["bill_id"].stringValue
                self.detail_content[1] = jsonResults[0]["bill_type"].stringValue
                self.detail_content[2] = jsonResults[0]["sponsor"]["title"].stringValue + " " +
                    jsonResults[0]["sponsor"]["first_name"].stringValue + " " +
                    jsonResults[0]["sponsor"]["last_name"].stringValue
                self.detail_content[3] = jsonResults[0]["last_action_at"].stringValue
                self.detail_content[4] = jsonResults[0]["last_version"]["urls"]["pdf"].stringValue
                self.detail_content[5] = jsonResults[0]["chamber"].stringValue
                self.detail_content[6] = jsonResults[0]["last_vote_at"].stringValue
                if(jsonResults[0]["active"].stringValue == "true") {
                    self.detail_content[7] = "Active"
                } else {
                    self.detail_content[7] = "New"
                }
//                print(self.detail_content)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "BillDetailsCell") as! BillDetailsTableViewCell
        
        cell.detailHeaderLabel.text = self.detail_header[indexPath.row]
        if(self.detail_content[indexPath.row] == "") {
            cell.detailContentLabel.text = "NA"
            return cell
        }
        if(self.detail_header[indexPath.row] == "PDF")  {
            cell.detailContentLabel.text = "PDF"
            let tap = UITapGestureRecognizer(target: self, action: #selector(BillDetailsViewController.openPDF))
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
    
    func openPDF(sender:UITapGestureRecognizer) {
        open(scheme: self.detail_content[4])
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
