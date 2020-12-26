//
//  DesignableTextfield.swift
//  walletest
//
//  Created by Darko, Tenkorang on 7/26/18.
//  Copyright © 2018 Darko, Tenkorang. All rights reserved.
//

import UIKit

@IBDesignable
class TextfieldNice: UITextField {


    var delegateForDrop : showHelper?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    @IBInspectable var borderBottomColor: UIColor? {
        didSet {
            bottomBorder()
            updateView()
        }
    }
    
    func bottomBorder(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red:0.44, green:0.60, blue:0.14, alpha:1.0).cgColor
        
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width+100, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
   
    
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
            bottomBorder()
        }
    }
    
    
    @IBInspectable var rightimage: UIImage? {

        didSet {
            
            updateView()
            bottomBorder()
            
        }
    }
    
    
    
    @objc func callDelegate(){
        
        switch self.tag {
        case 4:
            delegateForDrop?.showHelper()
            break
        case 5:
            delegateForDrop?.showHelper()
            break
        default:
            delegateForDrop?.showHelper()
        }
        
    }
    
    
    func updateView(){
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 20, height: 20))
            
            imageView.image = image
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
            view.addSubview(imageView)
            
            leftView = view
            
            
            
        } else {
            leftViewMode = .never
        }
        
        if let image = rightimage {
            rightViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 20, height: 20))
            
            imageView.image = image
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
            view.addSubview(imageView)
            
            rightView = view
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(callDelegate))
            rightView?.addGestureRecognizer(tap)
            
        } else {
            rightViewMode = .never
        }
        
        
        
        
        if let borderColor = borderBottomColor {
            let border = CALayer()
            let width = CGFloat(2.0)
            border.borderColor = borderColor.cgColor
            
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
            
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
            
        }
    }
    

}
