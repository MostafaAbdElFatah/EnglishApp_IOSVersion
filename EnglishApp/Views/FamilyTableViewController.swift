//
//  FamilyTableViewController.swift
//  EnglishApp
//
//  Created by Mostafa AbdEl Fatah on 10/25/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit
import AVFoundation

class FamilyTableViewController: UITableViewController {

    var family:Words = Words()
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(FamilyTableViewController.swipeLeft(_:)))
        swipeLeft.direction = [.left]
        tableView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(FamilyTableViewController.swipeRight(_:)))
        swipeRight.direction = [.right]
        tableView.addGestureRecognizer(swipeRight)
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc func swipeLeft(_ gesture:UISwipeGestureRecognizer){
        self.tabBarController?.selectedIndex += 1
    }
    @objc func swipeRight(_ gesture:UISwipeGestureRecognizer){
        self.tabBarController?.selectedIndex -= 1
    }
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "family", ofType: "json"){
            do {
                let contents = try String(contentsOfFile: path).data(using: .utf8)
                let familyData:Words = try! JSONDecoder().decode(Words.self, from: contents! )
                self.family = familyData
            } catch {
                // contents could not be loaded
            }
            
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.family.arabicWords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        // Configure the cell...
        cell.bgView?.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        cell.arabicLabel.text = self.family.arabicWords[indexPath.row]
        cell.englishLabel.text = self.family.englishWords[indexPath.row]
        cell.wordImageView.image = WordsImagesArrays.familyImages[indexPath.row]
        
        return cell
    }
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let word = self.family.englishWords[indexPath.row]
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }

}
