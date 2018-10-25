//
//  TableViewCell.swift
//  EnglishApp
//
//  Created by Mostafa AbdEl Fatah on 10/25/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var wordImageView: UIImageView!
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var widthImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingImageViewContraint: NSLayoutConstraint!
    
    @IBOutlet weak var leadingbBViewConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.wordImageView.clipsToBounds = true
        self.wordImageView.layer.cornerRadius =  self.wordImageView.frame.size.width / 2.0
        
    }
    func configImage() {
        self.wordImageView.layer.borderWidth = 2.0
        self.wordImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
