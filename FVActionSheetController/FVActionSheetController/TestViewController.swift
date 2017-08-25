
//
//  TestViewController.swift
//  FVActionSheetController
//
//  Created by huixiang on 2017/8/23.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var buttonClicked: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.setNavigationBarHidden(true, animated: animated);
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true);
        navigationController?.setNavigationBarHidden(false, animated: animated);
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
    @IBAction func imageviewClicked(_ sender: Any) {
        let str = helloWorld("hello world");
        print(str)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func helloWorld(_ sender: String) -> String {
        return sender;
    }
}
