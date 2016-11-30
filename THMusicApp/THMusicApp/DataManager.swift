//
//  DataManager.swift
//  THMusicApp
//
//  Created by Hai on 11/27/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager {
    
    static let shared = DataManager()
    
    
    let numberOfGenre = [2,3,4,5,6,7,9,10,11,12,14,15,16,17,18,19,20,21,22,24,34,50,51]

    
    func setUrl() -> [String] {
        var url : [String] = []
        for number in numberOfGenre {
            let urlGet = "https://itunes.apple.com/us/rss/topsongs/limit=50/genre=\(number)/explicit=true/json"
            print("Avava", number)
            print(urlGet)
            url.append(urlGet)
        }
        return url
    }
}

