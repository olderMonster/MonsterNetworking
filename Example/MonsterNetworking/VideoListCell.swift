//
//  HomeCell.swift
//  Monster_Example
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class VideoListCell: UICollectionViewCell {
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var onlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(gameLabel)
        contentView.addSubview(onlineLabel)
        contentView.addSubview(nicknameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coverImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(coverImageView.snp.width).multipliedBy(9.0/16.0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImageView.snp.bottom)
            make.right.equalTo(-2)
            make.left.equalTo(10)
            make.height.equalTo(30)
        }
        
        gameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        nicknameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(coverImageView).offset(-2)
        }
        
        onlineLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nicknameLabel)
            make.right.equalTo(-10)
        }
        
    }
    
    
    var video: Video! {
        didSet {
            coverImageView.kf.setImage(with: URL(string: video.room_src))
            titleLabel.text = video.room_name
            gameLabel.text = "\(video.game_name) >"
            nicknameLabel.text = video.nickname
            if video.online < 10000 {
                onlineLabel.text = "\(video.online)"
            } else {
                let count = CGFloat(video.online)/10000.0
                let text = String(format: "%.2f", count)
                onlineLabel.text = "\(text)万"
            }
            
        }
    }
    
}
