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
import ReachabilitySwift

class DataManager {
    
    static let shared = DataManager()
    
    
    let numberOfGenre = [2,3,4,5,6,7,9,10,11,12,14,15,16,17,18,19,20,21,22,24,34,50,51]
    

    var reachable = Reachability()
    
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
    func DataCell (url : String, completed: @escaping(_ songs: [Song]) -> Void)  {
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON(completionHandler: { (reponse) in
                guard let value = reponse.result.value else {
                    return
                }
                let json = JSON(value)
                guard let entries = json["feed"]["entry"].array else {
                    return
                }
                var songs = [Song]()
                for entry  in entries {
                    let song = Song()
                    guard let songName = entry["im:name"]["label"].string else {
                        return
                    }
                    print("name",songName)
                    guard let songArtist = entry["im:artist"]["label"].string else {
                        return
                    }
                    guard let songImage = entry["im:image"][2]["label"].string else {
                        return
                    }
                    song.image = songImage
                    song.artirst = songArtist
                    song.name = songName
                    songs.append(song)
                }
                completed(songs)
            })
        }
    }
    func findMusic (searchString: String,completed: @escaping(_ link: String) -> Void) {
        var score = 0.0
        let url = "http://api.mp3.zing.vn/api/mobile/search/song?requestdata={\"q\":\"\(searchString)\", \"sort\":\"hot\", \"start\":\"0\", \"length\":\"5\"}"
        print("url", url)
        let finalUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("final", finalUrl)
        DispatchQueue.main.async {
            Alamofire.request(finalUrl!).responseJSON(completionHandler: { (reponse) in
                guard let value = reponse.result.value else {
                    return
                }
                let json = JSON(value)
                guard let docs = json["docs"].array else {
                    return
                }
                var linkMusic = String()
                print("count", docs.count)
                for doc in docs {
                    guard let title =  doc["title"].string else {
                        return
                    }
                    
                    guard let artist = doc["artist"].string else {
                        return
                    }
                    print("title", title)
                    print("artist", artist)
                    print("search", searchString)
                    let keyword = title + " " + artist
                    let stringScore = searchString.score(keyword, fuzziness: 1.0)
                    print("score", stringScore)
                    if stringScore > score {
                        score = stringScore
                        guard let source = doc["source"]["128"].string else {
                            return
                        }
                        linkMusic = source
                    }
                }
                completed(linkMusic)
            })
            
        }
        
    }

    
    
    
}

