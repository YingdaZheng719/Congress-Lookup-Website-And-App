//
//  LeftViewController.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/24/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

enum LeftMenu: Int {
    case legislator = 0
    case bill
    case committee
    case favorite
    case about
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController: UIViewController, LeftMenuProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var menus = ["Legislators", "Bills", "Committees", "Favorites", "About"]
    var legislatorTabBarController: UIViewController!
    var billTabBarController: UIViewController!
    var committeeTabBarController: UIViewController!
    var favoriteTabBarController: UIViewController!
    var aboutViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.imageView.image = UIImage(named:"SunlightFoundation")
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.legislatorTabBarController = storyboard.instantiateViewController(withIdentifier: "LegislatorView") as! LegislatorTabBarController
        self.billTabBarController = storyboard.instantiateViewController(withIdentifier: "BillView") as! BillTabBarController
        self.committeeTabBarController = storyboard.instantiateViewController(withIdentifier: "CommitteeView") as! CommitteeTabBarController
        self.favoriteTabBarController = storyboard.instantiateViewController(withIdentifier: "FavoriteView") as! FavoriteTabBarController
        let aboutViewController = storyboard.instantiateViewController(withIdentifier: "AboutView") as! AboutViewController
        self.aboutViewController = UINavigationController(rootViewController: aboutViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .legislator:
            self.slideMenuController()?.changeMainViewController(self.legislatorTabBarController, close: true)
        case .bill:
            self.slideMenuController()?.changeMainViewController(self.billTabBarController, close: true)
        case .committee:
            self.slideMenuController()?.changeMainViewController(self.committeeTabBarController, close: true)
        case .favorite:
            self.slideMenuController()?.changeMainViewController(self.favoriteTabBarController, close: true)
        case .about:
            self.slideMenuController()?.changeMainViewController(self.aboutViewController, close: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .legislator, .bill, .committee, .favorite, .about:
                return 50
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .legislator, .bill, .committee, .favorite, .about:
                let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell", for: indexPath) as! LeftMenuCell
                
                let row = indexPath.row
                cell.menuLabel.text = menus[row]
                
                return cell
            }
        }
        return UITableViewCell()
    }

}



