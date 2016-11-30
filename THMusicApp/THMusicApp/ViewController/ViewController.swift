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
    var transition = PresentTransition()
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
        songViewController.url = url.value[indexPath.row]
        print(cell.nameGenre.text!)
        songViewController.image = cell.imageGenre.image
        songViewController.name = cell.nameGenre.text
        
//        print("cell", cell.center)
//        transition.index = indexPath
//        transition.fromImage?.image = cell.imageGenre.image
//        transition.fromImage?.center = CGPoint(x: 100, y: 100)
//        print("center",transition.fromImage?.center)
//        transition.toImage = songViewController.genreImage
//        
//        songViewController.transitioningDelegate = self
        self.navigationController?.pushViewController(songViewController, animated: true)
    }
    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return transition
//    }
    
    }

