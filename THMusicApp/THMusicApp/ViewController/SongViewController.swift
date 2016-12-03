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


class SongViewController: UIViewController, UITableViewDelegate,UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var songTableView: UITableView!
    @IBOutlet weak var genreImage: UIImageView!
    @IBOutlet weak var genreName: UILabel!
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerSongName: UILabel!
    @IBOutlet weak var playerSongArtist: UILabel!
    
    var index : Int?
    var position : CGPoint?
    var size : CGSize?
    var name : String?
    var image: UIImage?
    var fistSelect = true
    var selected : IndexPath?
    var songs : Variable<[Song]> = Variable<[Song]>([])
    var fisrtPlayer = true
    
    let transition = DismissTransition()
    
    var count : Variable<[String]> = Variable<[String]>([])
    var disposeBag = DisposeBag()
    
    var url = "https://itunes.apple.com/us/rss/topsongs/limit=50/genre=2/explicit=true/json"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songTableView.delegate = self
        self.setSongs()
        self.setCell()
        print("123", self.url)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tapGesture()
        self.setUI()
        DispatchQueue.main.async {
            self.songTableView.reloadData()
        }
    }
    func setSongs() {
        DataManager.shared.DataCell(url: self.url) { (songs) in
            for song in songs {
                self.songs.value.append(song)
            }
        }
    }
    func setCell () {
        self.songs.asObservable().bindTo(
            self.songTableView.rx.items(cellIdentifier: "SongTableViewCell", cellType: TableViewSongCell.self)
        ) { (row, url, cell) in
            cell.setCell(song: self.songs.value[row])
            }.addDisposableTo(self.disposeBag)
    }
    func setUI ()  {
        
        self.playerView.isHidden = true
        self.genreImage.image = self.image
        self.genreName.text = self.name
        
        UINavigationBar.appearance().tintColor = UIColor.darkGray
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Discover"
        self.navigationItem.hidesBackButton = true
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewSongCell
        cell.selectionStyle = .none
        if self.fistSelect {
            self.selected = indexPath
            cell.selectedCircle.isHidden = false
            self.fistSelect = false
        }
        let anotherCell = tableView.cellForRow(at: self.selected!) as! TableViewSongCell!
        cell.selectedCircle.isHidden = false
        if self.selected != indexPath {
            anotherCell?.selectedCircle.isHidden = true
        }
        self.selected = indexPath
        let searchString = cell.nameSong.text! + " " + cell.nameArtist.text!
        
        PlayMusic.shared.playMusic(searchString: searchString)
        self.playerViewSetup(image: cell.imageSong.image!, name: cell.nameSong.text!, artist: cell.nameArtist.text!)
        
        
    }
    
    func playerViewSetup(image: UIImage, name : String, artist : String )  {
        self.playerView.isHidden = false
        if self.fisrtPlayer {
            playerViewAnimation()
            self.fisrtPlayer = false
        }
        self.playerImage.layer.cornerRadius = playerImage.frame.width/2
        self.playerImage.clipsToBounds = true
        self.playerImage.image = image
        self.playerSongName.text = name
        self.playerSongArtist.text = artist
    }
    
    func playerViewAnimation() {
        self.playerView.frame.origin.y = self.view.frame.height
        UIView.animate(withDuration: 0.5) { 
            self.playerView.frame.origin.y = self.view.frame.height - self.playerView.frame.height
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
