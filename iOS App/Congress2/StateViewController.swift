//
//  StateViewController.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/23/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SwiftSpinner

class StateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    
    let pickerData = ["All States",
                      "Alabama","Alaska","Arizona","Arkansas","California",
                      "Colorado","Connecticut","Delaware","Florida", "Georgia",
                      "Hawaii","Idaho","Illinois","Indiana", "Iowa",
                      "Kansas","Kentucky","Louisiana","Maine", "Maryland",
                      "Massachusetts","Michigan","Minnesota","Mississippi", "Missouri",
                      "Montana","Nebraska","Nevada","New Hampshire", "New Jersey",
                      "New Mexico","New York","North Carolina","North Dakota", "Ohio",
                      "Oklahoma","Oregon","Pennsylvania","Rhode Island", "South Carolina",
                      "South Dakota","Tennessee","Texas","Utah", "Vermont",
                      "Virginia","Washington","West Virginia","Wisconsin", "Wyoming"]
    var selectedState : String = "All States"
    var legislatorImages = [UIImage?]()
    var legislatorFirstNames = [String]()
    var legislatorLastNames = [String]()
    var legislatorStates = [String]()
    var legislatorBioID = [String]()
    var firstNameIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
    var initialDictionaryKeySortedArr = [String]()
    //[Int] are corresponding indexs
    var initialDictionary = [String: [Int]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setNavigationBarItem()
        SwiftSpinner.show("Fetching data...")

        Alamofire.request("http://104.198.0.197:8080/legislators?per_page=all").validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                SwiftSpinner.hide()
                let json = JSON(value)
                let sortedResults = json["results"].arrayValue.sorted {$0["first_name"].stringValue < $1["first_name"].stringValue}
                self.legislatorBioID = sortedResults.map({$0["bioguide_id"].stringValue})
                self.legislatorFirstNames = sortedResults.map({$0["first_name"].stringValue})
                self.legislatorLastNames = sortedResults.map({$0["last_name"].stringValue})
                self.legislatorStates = sortedResults.map({$0["state_name"].stringValue})
                self.legislatorBioID = sortedResults.map({$0["bioguide_id"].stringValue})
                
                //create a dictionary according to the first name to implement fast index
                for i in 0..<self.legislatorFirstNames.count {
                    let firstName = self.legislatorFirstNames[i]
                    let firstChar = firstName.substring(to: firstName.index(firstName.startIndex, offsetBy: 1))
                    if(self.initialDictionary.keys.contains(firstChar)) {
                        self.initialDictionary[firstChar]?.append(i)
                    } else {
                        self.initialDictionary[firstChar] = [i]
                    }
                    
                }
                self.initialDictionaryKeySortedArr = self.initialDictionary.keys.sorted()
                
                self.tableView.reloadData()
                
                self.legislatorImages = [UIImage?](repeating: nil, count:self.legislatorBioID.count)
                for i in 0..<self.legislatorBioID.count {
                    Alamofire.request("https://theunitedstates.io/images/congress/original/\(self.legislatorBioID[i]).jpg").responseImage { response in
                        
                        //search dictionary for
                        let firstName = self.legislatorFirstNames[i]
                        let firstChar = firstName.substring(to: firstName.index(firstName.startIndex, offsetBy: 1))
                        let section = self.initialDictionaryKeySortedArr.index(of: firstChar)
                        let row = self.initialDictionary[firstChar]!.index(of: i)
                        
                        if let image = response.result.value {
                            self.legislatorImages[i] = image
                            let indexPath = NSIndexPath(row: row!, section: section!)
                            self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
                        }
                    }
                    
                }
                
            case .failure(let error):
                SwiftSpinner.show("Failed to connect, waiting...", animated: false)
                print(error)
            }
        }
        tableView.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func filterBtn(_ sender: AnyObject) {
        if(tableView.isHidden == false) {
            tableView.isHidden = true
        } else {
            self.tableView.reloadData()
            tableView.isHidden = false
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerData[row])
        self.selectedState = pickerData[row]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  initialDictionary.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.initialDictionary[initialDictionaryKeySortedArr[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateTableCell", for: indexPath) as! StateTableViewCell
        
        let row = indexPath.row
        
        //An [Int] type contains all indexs of array of legislators, that is, the location of corresponding info in the array for this section
        let resultsOfThisSection = self.initialDictionary[initialDictionaryKeySortedArr[indexPath.section]]!
        
        cell.legislatorImage.image = legislatorImages[resultsOfThisSection[row]]
        cell.legislatorFirstNameLabel.text = legislatorFirstNames[resultsOfThisSection[row]]
        cell.legislatorLastNameLabel.text = legislatorLastNames[resultsOfThisSection[row]]
        cell.legislatorStateLabel.text = legislatorStates[resultsOfThisSection[row]]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return initialDictionaryKeySortedArr[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return initialDictionaryKeySortedArr
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    {
        return initialDictionaryKeySortedArr.index(of: title)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.selectedState == "All States") {
            return 50
        }
        
        let row = indexPath.row
        let section = indexPath.section
        let resultsOfThisSection = self.initialDictionary[initialDictionaryKeySortedArr[section]]!
        
        if(legislatorStates[resultsOfThisSection[row]] == self.selectedState) {
            return 50
        }
        return 0
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetails" {
            let detailsViewController = segue.destination as! DetailsViewController
            let section = self.tableView.indexPathForSelectedRow!.section
            let row = self.tableView.indexPathForSelectedRow!.row
            let position = initialDictionary[initialDictionaryKeySortedArr[section]]![row]
            
            detailsViewController.bioID = legislatorBioID[position]
            detailsViewController.image = legislatorImages[position]
        }
    }
    

}
