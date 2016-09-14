

import UIKit

class CDSwipeView: UIView {
    
    let screenW = UIScreen.main.bounds.width
    let screenH = UIScreen.main.bounds.height
    
    let scrItemW = UIScreen.main.bounds.width * 0.42
    let scrItemH = UIScreen.main.bounds.width * 0.6
    
    var backImageView: UIImageView!
    var bottonScrollView: UIScrollView!
    
    
    
    var images = [SwipeItem]()
    
    var selectWindow : CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // background image
        backImageView = UIImageView(frame: bounds)
        backImageView.contentMode = .scaleAspectFill
        addSubview(backImageView)
        
        
        // 底部滚动视图
        let y = screenH * 2.4 / 4
        
        bottonScrollView = UIScrollView(frame: CGRect(x: 0, y: y, width: screenW, height: scrItemH))
        bottonScrollView.backgroundColor = UIColor.clear
        bottonScrollView.showsHorizontalScrollIndicator = false
        bottonScrollView.clipsToBounds = true
        bottonScrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        addSubview(bottonScrollView)
        
        let offset = (screenW - scrItemW) * 0.5
        bottonScrollView.contentInset = UIEdgeInsetsMake(0, offset, 0, offset)
        bottonScrollView.contentOffset = CGPoint(x: -offset, y: 0)
        
//        bottonScrollView.layer.shadowRadius = 50
//        bottonScrollView.layer.shadowOpacity = 0.9
//        bottonScrollView.layer.shadowColor = UIColor.blackColor().CGColor
//        bottonScrollView.layer.shadowOffset = CGSizeMake(0, 0)
                
        selectWindow = CGRect(x:offset, y: y, width: scrItemW, height: scrItemH)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setUpContents(images: [UIImage]){
        
        backImageView.image = images.first
        
        
        for en in images.enumerated() {
            
            let item = SwipeItem(frame: CGRect(x: CGFloat(en.0) * scrItemW, y: 0, width: scrItemW, height: scrItemH))
                item.itemIma.image = en.1
            bottonScrollView.addSubview(item)
            self.images.append(item)
        }
        
        bottonScrollView.contentSize = CGSize(width: CGFloat(images.count) * scrItemW, height: 0)
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        for en in self.images.enumerated() {
         
            let poi = self.bottonScrollView.convert(en.1.center, to: self)
            if selectWindow.contains(poi) {
                self.setUpbackGround(index: en.0)
                break
            }
        }
    }
    
    /*
     

     */
    var currentIndex = 0
    func setUpbackGround(index: Int){
        
        if index == currentIndex {
            return
        } else {
            currentIndex = index
        }
        UIView.transition(with: self.backImageView, duration: 0.4, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.backImageView.image = self.images[index].itemIma.image!
            }) { (bol) in
                
        }
    }
    
    class SwipeItem: UIView {
        
        var itemIma: UIImageView!
        
        override init(frame: CGRect){
            super.init(frame: frame)
            backgroundColor = UIColor.clear
            
            itemIma = UIImageView(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height - 20))
            itemIma.contentMode = .scaleAspectFill
            itemIma.layer.shadowColor = UIColor.black.cgColor
            itemIma.layer.cornerRadius = 15
            self.itemIma.clipsToBounds = true
            self.clipsToBounds = true
            addSubview(itemIma)
            
        }
        
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
}
