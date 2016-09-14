//
//  ViewController.swift
//  CDSwipe
//
//  Created by chdo on 2016/9/14.
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
            test.setUpContents(images: images)
            view.addSubview(test)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

