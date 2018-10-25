//
//  PhrasesTableViewController.swift
//  EnglishApp
//
//  Created by Mostafa AbdEl Fatah on 10/25/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit
import AVFoundation

class PhrasesTableViewController: UITableViewController {

    var phrases:Words = Words()
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    func loadData(){
        if let path = Bundle.main.path(forResource: "phrases", ofType: "json"){
            do {
                let contents = try String(contentsOfFile: path).data(using: .utf8)
                let phrasesData:Words = try! JSONDecoder().decode(Words.self, from: contents! )
                self.phrases = phrasesData
            } catch {
                // contents could not be loaded
            }
            
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.phrases.arabicWords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        // Configure the cell...
        cell.bgView?.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        cell.arabicLabel.text = self.phrases.arabicWords[indexPath.row]
        cell.englishLabel.text = self.phrases.englishWords[indexPath.row]
        cell.wordImageView.isHidden = true
        cell.widthImageConstraint.constant = 0.0
        cell.leadingImageViewContraint.constant = 0.0
        cell.leadingbBViewConstraint.constant = 0.0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let word = self.phrases.englishWords[indexPath.row]
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }

}
