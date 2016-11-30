//
//  SongViewController.swift
//  THMusicApp
//
//  Created by Hai on 11/29/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxCocoa
import RxSwift


class SongViewController: UIViewController, UITableViewDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var genreImage: UIImageView!
    @IBOutlet weak var genreName: UILabel!
    
    var index : Int?
    var position : CGPoint?
    var size : CGSize?
    var name : String?
    var image: UIImage?
    
    let transition = DismissTransition()
    
    var count : Variable<[String]> = Variable<[String]>([])
    var disposeBag = DisposeBag()

    var url = "https://itunes.apple.com/us/rss/topsongs/limit=50/genre=2/explicit=true/json"
    
    @IBOutlet weak var songTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.songTableView.delegate = self
        self.addCount()
        self.setCell()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tapGesture()
        self.setUI()
        DispatchQueue.main.async {
            self.songTableView.reloadData()
        }
        }
    
    func setCell () {
        self.count.asObservable().bindTo(
            self.songTableView.rx.items(cellIdentifier: "SongTableViewCell", cellType: TableViewSongCell.self)
        ) { (row, url,cell) in
            cell.setCell(url: self.url, row: row)
            }.addDisposableTo(self.disposeBag)
        self.songTableView.reloadData()
    }
    
    func setUI ()  {
        self.genreImage.image = self.image
        self.genreName.text = self.name
        
        UINavigationBar.appearance().tintColor = UIColor.darkGray
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Discover"
        self.navigationItem.hidesBackButton = true
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        
    }

    func addCount()  {
        for i in 0..<50 {
            let stringI = "\(i)"
            self.count.value.append(stringI)
        }
    }
    func tapGesture ()  {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        self.genreImage.addGestureRecognizer(tap)
    }
    func tapImage () {
        print("song", self.index, self,size, self.position)
        
        self.transition.index = self.index
        self.transition.size = self.size
        self.transition.position = self.position
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
