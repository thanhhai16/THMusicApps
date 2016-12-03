//
//  TableViewSongCell.swift
//  THMusicApp
//
//  Created by Hai on 11/29/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import RxCocoa
import RxSwift
import SDWebImage
import ReachabilitySwift
import AVFoundation

class TableViewSongCell : UITableViewCell {
    
    @IBOutlet weak var selectedCircle: UIView!
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var nameArtist: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    let reachable = Reachability()
    
    var musicUrl : String?
    
    static let shared = TableViewSongCell()
    
    func setCell(song : Song)  {
        self.uiSetting()
        self.nameSong.text = song.name
        self.nameArtist.text = song.artirst
        let url = URL(string: song.image!)
        self.imageSong.sd_setImage(with: url, placeholderImage: UIImage(named: "itunes12.png"))
    }
    
    
       
    func uiSetting () {
        self.imageSong.layer.cornerRadius = self.imageSong.frame.width/2
        self.imageSong.clipsToBounds = true
        self.selectedCircle.isHidden = true
        self.selectedCircle.layer.cornerRadius = self.selectedCircle.frame.width/2
    }
}
