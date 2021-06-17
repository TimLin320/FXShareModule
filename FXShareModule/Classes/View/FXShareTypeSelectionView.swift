//
//  FXShareTypeSelectionView.swift
//  FXShare
//
//  Created by Lyman on 2021/3/12.
//
//  栗子：分享方式选择弹框
//

import UIKit
import AKExts
import AKHud
import WechatOpenSDK

/// 分享方式弹框
public class FXShareTypeSelectionView: UIView, FXShareTypeSelection {
    
    public var selectClosure: ((FXShareType) -> Void)
    public var cancelClosure: (() -> Void)
    
    /// 方式列表
    public var types: [FXShareType] = [.friend, .circle, .album]
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 256.0)
    }
    
    init(types: [FXShareType],
         selectClosure: @escaping (FXShareType) -> Void,
         cancelClosure: @escaping () -> Void) {
        self.types = types
        self.selectClosure = selectClosure
        self.cancelClosure = cancelClosure
        super.init(frame: .zero)

        addAllSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func onCancelBtnClicked() {
        cancelClosure()
        hide()
    }
    
    func hide() {
        alpha = 1.0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let itemW = floor((UIScreen.main.bounds.size.width - 10.0 * 2.0) / CGFloat(types.count))
        
        let flow = UICollectionViewFlowLayout.init()
        flow.sectionInset = .init(top: 0, left: 10.0, bottom: 0, right: 10.0)
        flow.itemSize = CGSize.init(width: itemW, height: 72)
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 0.0
        flow.minimumLineSpacing = 0.0
        
        
        let view = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: flow)
        view.register(FXShareTypeSelectionCell.self, forCellWithReuseIdentifier: String.init(describing: FXShareTypeSelectionCell.self))
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.ak.RGBA(0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        btn.backgroundColor = UIColor.ak.RGBA(0xF5F5F5)
        btn.addTarget(self, action: #selector(onCancelBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.ak.RGBA(0x999999)
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.text = "分享到"
        return label
    }()
    
    func addAllSubviews() {
        self.backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(35.0)
            make.centerX.equalToSuperview()
        }

        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(97.0)
            make.left.right.equalToSuperview()
            make.height.equalTo(72.0)
        }
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(45.0)
            make.bottom.equalToSuperview()
        }
    }
}

extension FXShareTypeSelectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: FXShareTypeSelectionCell.self), for: indexPath) as? FXShareTypeSelectionCell {
            let type = types[indexPath.row]
            cell.configData(type: type)
            return cell
        }
        fatalError()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = types[indexPath.row]
        switch type {
        case .friend, .circle:
            if WXApi.isWXAppInstalled() {
                selectClosure(type)
            } else {
                AKHud.showToast("请安装微信客户端")
            }
        default:
            selectClosure(type)
        }
        hide()
    }
}
