//
//  FavoriteData.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/27/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import Foundation
import UIKit

class FavoriteData {
    static var sharedInstance = FavoriteData()
    
    var legislatorImages = [UIImage?]()
    var legislatorFirstNames = [String]()
    var legislatorLastNames = [String]()
    var legislatorStates = [String]()
    var legislatorBioID = [String]()
    
    var billID = [String]()
    var billOfficialTitle = [String]()
    
    var committeeID = [String]()
    var committeeName = [String]()
    
    private init() {
        
    }
    func displayInstance() {
        print(legislatorFirstNames)
        print(billID)
        print(committeeID)
    }
    
    
    //append/remove/check new legislator
    func addFavorLegis(image: UIImage?, firstName: String?, lastName: String?, state: String?, id: String?) {
        legislatorImages.append(image)
        legislatorFirstNames.append(firstName!)
        legislatorLastNames.append(lastName!)
        legislatorStates.append(state!)
        legislatorBioID.append(id!)
    }
    func removeFavorLegis(bioID: String?) {
        let index = legislatorBioID.index(of: bioID!)!
        legislatorImages.remove(at: index)
        legislatorFirstNames.remove(at: index)
        legislatorLastNames.remove(at: index)
        legislatorStates.remove(at: index)
        legislatorBioID.remove(at: index)
    }
    func isFavorLegis(bioID: String?) -> Bool {
        if(legislatorBioID.contains(bioID!)) {
            return true
        }
        return false
    }
    //append/remove/check new bill
    func addFavorBill(id: String?, title: String?) {
        billID.append(id!)
        billOfficialTitle.append(title!)
    }
    func removeFavorBill(id: String?) {
        let index = billID.index(of: id!)!
        billID.remove(at: index)
        billOfficialTitle.remove(at: index)
    }
    func isFavorBill(id: String?) -> Bool {
        if(billID.contains(id!)) {
            return true
        }
        return false
    }
    //append/remove/check new committee
    func addFavorCommittee(id: String?, name: String?) {
        committeeID.append(id!)
        committeeName.append(name!)
    }
    func removeFavorCommittee(id: String?) {
        let index = committeeID.index(of: id!)!
        committeeID.remove(at: index)
        committeeName.remove(at: index)
    }
    func isFavorCommittee(id: String?) -> Bool {
        if(committeeID.contains(id!)) {
            return true
        }
        return false
    }
}
