//
//  ViewController.swift
//  FVActionSheetController
//
//  Created by huixiang on 2017/8/10.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var action_oneClick: UIButton!
    
    override func viewDidLoad() {

        super.viewDidLoad()
    }
    
    @IBAction func aciton_one_click(_ sender: Any) {
        let sb = UIStoryboard.init(name: "TestViewController", bundle: nil);
        navigationController?.pushViewController(sb.instantiateInitialViewController()!, animated: true)
    }
}

