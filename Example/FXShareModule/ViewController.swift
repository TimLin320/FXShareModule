//
//  ViewController.swift
//  FXShareModule
//
//  Created by linmeng320@gmail.com on 06/08/2021.
//  Copyright (c) 2021 linmeng320@gmail.com. All rights reserved.
//

import UIKit
import FXShareModule
import AKHud

class ViewController: UIViewController, FXShare {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    @IBAction func shareAction() {
//        guard let image = UIImage.init(named: "common_placeholder_search") else {
//            AKHud.showToast("图片加载失败")
//            return
//        }
//
//        beginShare(images: [image], copyText: "分享文案", types: [.friend, .circle, .album]) { result in
//            switch result {
//            case .succeed:
//                AKHud.showToast("分享成功")
//            default: break
//            }
//        }
    }
    
    func shouldBeginShare() -> Bool {
        return true
    }
}

