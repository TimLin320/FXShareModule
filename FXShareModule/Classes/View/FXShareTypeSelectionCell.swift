//
//  FXShareTypeSelectionCell.swift
//  FXShare
//
//  Created by Lyman on 2021/5/10.
//

import UIKit
import AKExts

/// 分享方式弹框
public class FXShareTypeSelectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configData(type: FXShareType) {
        iconImgView.image = UIImage.init(named: type.imageName)
        titleLabel.text = type.title
    }
    
    func addAllSubviews(){
        contentView.addSubview(iconImgView)
        contentView.addSubview(titleLabel)
        
        iconImgView.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImgView.snp.bottom).offset(8)
            make.centerX.equalTo(iconImgView)
        }
    }
    
    lazy var iconImgView: UIImageView = {
        let view = UIImageView.init()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.ak.RGBA(0x333333)
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
}
