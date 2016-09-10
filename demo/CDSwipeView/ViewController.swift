//
//  ViewController.swift
//  CDSwipeView
//
//  Created by chdo on 16/9/10.
//  Copyright © 2016年 chdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let test = CDSwipeView(frame: self.view.bounds)
        var images = [UIImage]()
        for i in 1...7 {
            let im = UIImage(named: "\(i)")
            images.append(im!)
        }
            test.setUpContents(images)
        view.addSubview(test)
    }


}

