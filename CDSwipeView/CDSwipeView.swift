

import UIKit

class CDSwipeView: UIView {
    
    let screenW = UIScreen.mainScreen().bounds.width
    let screenH = UIScreen.mainScreen().bounds.height
    
    let scrItemW = UIScreen.mainScreen().bounds.width * 0.4
    let scrItemH = UIScreen.mainScreen().bounds.width * 0.6
    
    var backImageView: UIImageView!
    var bottonScrollView: UIScrollView!
    
    
    
    var images = [UIImageView]()
    
    var selectWindow : CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // background image
        backImageView = UIImageView(frame: bounds)
        backImageView.contentMode = .ScaleAspectFill
        addSubview(backImageView)
        
        
        // 底部滚动视图
        let y = screenH * 2.5 / 4
        
        bottonScrollView = UIScrollView(frame: CGRectMake(0,y, screenW, scrItemH))
        bottonScrollView.backgroundColor = UIColor.clearColor()
        bottonScrollView.showsHorizontalScrollIndicator = false
        bottonScrollView.clipsToBounds = true
        bottonScrollView.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        addSubview(bottonScrollView)
        
        let offset = (screenW - scrItemW) * 0.5
        bottonScrollView.contentInset = UIEdgeInsetsMake(0, offset, 0, offset)
        bottonScrollView.contentOffset = CGPointMake(-offset, 0)
//        bottonScrollView.layer.shadowRadius = 50
//        bottonScrollView.layer.shadowOpacity = 0.9
//        bottonScrollView.layer.shadowColor = UIColor.blackColor().CGColor
//        bottonScrollView.layer.shadowOffset = CGSizeMake(0, 0)
                
        selectWindow = CGRectMake(offset, y, scrItemW, scrItemH)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setUpContents(images: [UIImage]){
        
        backImageView.image = images.first
        
        
        for en in images.enumerate() {
            let item = UIImageView(frame: CGRectMake(CGFloat(en.0) * scrItemW, 0, scrItemW, scrItemH))
                item.contentMode = .ScaleAspectFill
                item.clipsToBounds = true
                item.image = en.1
            bottonScrollView.addSubview(item)
            self.images.append(item)
        }
        bottonScrollView.contentSize = CGSizeMake(CGFloat(images.count) * scrItemW, 0)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        for en in self.images.enumerate() {
            
            let poi = self.bottonScrollView.convertPoint(en.1.center, toView: self)
            if selectWindow.contains(poi) {
                self.setUpbackGround(en.0)
                break
            }
        }
    }
    var currentIndex = 0
    func setUpbackGround(index: Int){
        
        if index == currentIndex {
            return
        } else {
            currentIndex = index
        }
        UIView.transitionWithView(self.backImageView, duration: 0.4, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            self.backImageView.image = self.images[index].image!
            }) { (bol) in
                
        }
    }
}
