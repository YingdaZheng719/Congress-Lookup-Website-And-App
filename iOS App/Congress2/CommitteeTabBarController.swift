//
//  CommitteeTabBarController.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/24/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit

class CommitteeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Committees"
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: Selector(("btnOpenSearch")))
        self.navigationItem.rightBarButtonItem = search
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
