//
//  CollectionGenreCell.swift
//  THMusicApp
//
//  Created by Hai on 11/27/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxCocoa
import RxSwift
import ReachabilitySwift



class CollectionGenreCell : UICollectionViewCell {
    
    @IBOutlet weak var imageGenre: UIImageView!
    
    @IBOutlet weak var nameGenre: UILabel!
    
    var reach = Reachability()
    
    let numberOfGenre = [2,3,4,5,6,7,9,10,11,12,14,15,16,17,18,19,20,21,22,24,34,50,51]
    
    func setCell(url : String, row : Int) {
       
            DispatchQueue.main.async {
                Alamofire.request(url).responseJSON(completionHandler: { (reponse) in
                    guard let value = reponse.result.value else {
                        return
                    }
                    let json = JSON(value)
                    guard let genreTilte = json["feed"]["title"]["label"].string else {
                        return
                    }
                    let finalGenre = genreTilte.replacingOccurrences(of: "iTunes Store: Top Songs in", with: "")
                    self.nameGenre.text = finalGenre
                })
            }
            let imageFormat = "genre-\(self.numberOfGenre[row])@2x.png.png"
            
            self.imageGenre.image = UIImage(named: imageFormat)
        
                
    }
}
