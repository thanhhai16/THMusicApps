//
//  ViewController.swift
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


class ViewController: UIViewController, UICollectionViewDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var collectionGenre: UICollectionView!
        
    var url: Variable<[String]> = Variable<[String]>(DataManager.shared.setUrl())
    var disposeBag = DisposeBag()
    var present = PresentTransition()
    var dismiss = DismissTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionGenre.delegate = self
        
        DispatchQueue.main.async {
            self.setCell()
            self.collectionGenre.reloadData()
        }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            }
    
    
    func setCell ()  {
            self.url.asObservable().bindTo(
                self.collectionGenre.rx.items(cellIdentifier: "collectionGenre", cellType: CollectionGenreCell.self)
            ) { (row, url,cell) in
                cell.setCell(url: url, row: row)
                print(cell.nameGenre)
                }.addDisposableTo(self.disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let songViewController = self.storyboard?.instantiateViewController(withIdentifier: "SongViewController") as! SongViewController
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionGenreCell
        
        let position = CGPoint(x: cell.imageGenre.frame.origin.x, y: cell.imageGenre.frame.origin.y)
        self.present.index = indexPath.row
        self.present.position = cell.convert(position, to: self.view)
        self.present.size = cell.imageGenre.frame.size
        
        self.dismiss.index = indexPath.row
        self.dismiss.position = cell.convert(position, to: self.view)
        self.dismiss.size = cell.imageGenre.frame.size

        
        songViewController.image = cell.imageGenre.image
        songViewController.name = cell.nameGenre.text
        songViewController.transitioningDelegate = self
        songViewController.url = url.value[indexPath.row]
        songViewController.index = indexPath.row
        songViewController.size = cell.imageGenre.frame.size
        songViewController.position = position
        //self.navigationController?.pushViewController(songViewController, animated: true)
        self.present(songViewController, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return present
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismiss
    }
        }

