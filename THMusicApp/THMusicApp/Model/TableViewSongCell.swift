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

class TableViewSongCell : UITableViewCell {
    
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var nameArtist: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    let reachable = Reachability()
    
    func setCell(url: String, row: Int)  {
        self.uiSetting()
        self.DataCell(url: url, row: row)
    }
    
    func DataCell (url : String, row: Int)  {
        reachable?.whenReachable = { reachable in
            DispatchQueue.main.async {
                Alamofire.request(url).responseJSON(completionHandler: { (reponse) in
                    guard let value = reponse.result.value else {
                        return
                    }
                    let json = JSON(value)
                    print("row",row)
                    guard let songName = json["feed"]["entry"][row]["im:name"]["label"].string else {
                        return
                    }
                    print("avav",songName)
                    
                    guard let songArtist = json["feed"]["entry"][row]["im:artist"]["label"].string else {
                        return
                    }
                    guard let songImage = json["feed"]["entry"][row]["im:image"][2]["label"].string else {
                        return
                    }
                    let url = URL(string: songImage)
                    self.imageSong.sd_setImage(with: url!, placeholderImage: UIImage(named: "itunes12.png"))
                    self.nameSong.text = songName
                    self.nameArtist.text = songArtist
                    
                })
            }
        }
        reachable?.whenUnreachable = { reachable in
            print("not connect")
        }
        
        try! reachable?.startNotifier()
        
    }
    
    func uiSetting () {
        self.imageSong.layer.cornerRadius = self.imageSong.frame.width/2
        self.imageSong.clipsToBounds = true
    }
}
