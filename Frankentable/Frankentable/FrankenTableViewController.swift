//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {

    var wordFrequencyDictionary: [String: Int] = [:]
    var wordFrequencyArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            countWords(data: (text))
            makeDictIntoArray(dict: wordFrequencyDictionary)
        }
    }
    
    func countWords(data: String) {
        let dataArray = data.components(separatedBy: [" ", "\n", ".", ",", "'", "-", ])
        var frequencyDictionary = [String:Int]()
        for word in dataArray {
            if let oldFrequencyDictionary = frequencyDictionary[word] {
                frequencyDictionary[word] = oldFrequencyDictionary + 1
            } else {
               frequencyDictionary[word] = 1
            }
        }
        wordFrequencyDictionary = frequencyDictionary
    }
    
    func makeDictIntoArray(dict: [String:Int]) {
        var arr = [String]()
        for (k,v) in dict {
            let temp = "\(k.capitalized), (\(v))"
            arr.append(temp)
        }
        wordFrequencyArray = arr.sorted()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordFrequencyArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let rowToSetUp = indexPath.row
        let dataToDisplay = wordFrequencyArray[rowToSetUp]
        cell.textLabel?.text = dataToDisplay
        return cell
    }
    
}
