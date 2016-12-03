//
//  PlayMusic.swift
//  THMusicApp
//
//  Created by Hai on 12/3/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import AVFoundation
import UIKit


class PlayMusic {
    static let shared =  PlayMusic()
    var player = AVPlayer()
    
    func playMusic(searchString: String) {
        DataManager.shared.findMusic(searchString: searchString) { (link) in
            print("link",link)
            let playURL = URL(string: link)
            self.player = AVPlayer(url: playURL!)
            self.player.play()
        }
    }
    
}
