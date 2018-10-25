//
//  DataModels.swift
//  EnglishApp
//
//  Created by Mostafa AbdEl Fatah on 10/25/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import Foundation

class Words: Codable {
    var arabicWords:[String] = []
    var englishWords:[String] = []
    
    enum CodingKeys: String, CodingKey
    {
        case arabicWords = "ar"
        case englishWords = "en"
    }
}

