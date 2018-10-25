//
//  ColorTableViewController.swift
//  EnglishApp
//
//  Created by Mostafa AbdEl Fatah on 10/25/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit
import AVFoundation

class ColorTableViewController: UITableViewController {

    var colors:Words = Words()
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    func loadData(){
        if let path = Bundle.main.path(forResource: "colors", ofType: "json"){
            do {
                let contents = try String(contentsOfFile: path).data(using: .utf8)
                let colorsData:Words = try! JSONDecoder().decode(Words.self, from: contents! )
                self.colors = colorsData
            } catch {
                // contents could not be loaded
            }
            
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.colors.arabicWords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        // Configure the cell...

        cell.bgView?.backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        cell.arabicLabel.text = self.colors.arabicWords[indexPath.row]
        cell.englishLabel.text = self.colors.englishWords[indexPath.row]
        cell.wordImageView.backgroundColor = WordsImagesArrays.colors[indexPath.row]
        if indexPath.row == 5 {
            cell.configImage()
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let word = self.colors.englishWords[indexPath.row]
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }

}
