//
//  HomeViewController.swift
//  Monster_Example
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import MonsterNetworking
import SwiftyJSON

class VideoListController: UIViewController {
    
    
    lazy var videoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        view.register(VideoListCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "斗鱼"
        view.backgroundColor = .white
        view.addSubview(videoCollectionView)
        
        loadData()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        videoCollectionView.frame = view.bounds
    }
    
}


//MARK: -- http request
extension VideoListController {
    func loadData() {
        
        APIManager.request(methodName: "api/v1/live?limit=20&offset=0") {  [unowned self] result in
            switch result {
            case .success(let json):
                let dataArray = JSON(json).arrayValue
                let models = dataArray.compactMap { Video(json: $0) }
                self.videos = models
                self.videoCollectionView.reloadData()
                
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}

//MARK: -- UICollectionViewDataSource
extension VideoListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoListCell
        cell.video = videos[indexPath.row]
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
}

//MARK: -- UICollectionViewDelegateFlowLayout
extension VideoListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (UIScreen.main.bounds.width - layout.minimumInteritemSpacing) * 0.5
        let height = width * 9.0/16.0 + 30 + 20
        return CGSize(width: width, height: height)
    }
}
