//
//  OnboardingViewController.swift
//  Sika
//
//  Created by KWAME DARKO on 10/11/20.
//  Copyright © 2020 KWAME DARKO. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet var beginButton: RoundButton!
    
    
    @IBAction func getStarted(_ sender: Any) {
        self.performSegue(withIdentifier: "invitationCode", sender: nil)
    }
    
    
    
    @IBOutlet var footerView: UIView!
    
    
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: UIImage(named: "happyface.jpg")!,
                           title: "Welcome to SIKA",
                           description: "The App that pays you money for filling out surveys",
                           pageIcon: UIImage(named: "swipeLeft2.png")!,
                           color: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                           titleColor: UIColor.lightGray, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "OW-tilt2.png")!,
                           title: "Choose a survey",
                           description: "Pick from hundreds of surveys",
                           pageIcon: UIImage(named: "OW-tilt2.png.png")!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "OW-progress-1.png")!,
                           title: "Complete the survey",
                           description: "Receive coins for completing surveys",
                           pageIcon: UIImage(named: "OW-progress-1.png.png")!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "paymentgift.png")!,
                           title: "Choose a payment method",
                           description: "Paypal, Amazon, Starbucks",
                           pageIcon: UIImage(named: "paymentgift.png")!,
                           color: UIColor(red: 1, green: 1, blue: 1, alpha: 1.00),
                           titleColor: UIColor.lightGray, descriptionColor: UIColor.lightGray, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "enjoyMoney.png")!,
                           title: "Get paid",
                           description: "Enjoy your money",
                           pageIcon: UIImage(named: "enjoyMoney.png.png")!,
                           color: UIColor(red: 1, green: 1, blue: 1, alpha: 1.00),
                           titleColor: UIColor.lightGray, descriptionColor: UIColor.lightGray, titleFont: titleFont, descriptionFont: descriptionFont)
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPaperOnboardingView()
        view.bringSubviewToFront(beginButton)
        view.bringSubviewToFront(footerView)

        beginButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    

    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }

}


extension OnboardingViewController: PaperOnboardingDataSource {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        beginButton.isHidden = index == 4 ? false : true
        footerView.isHidden = index == 4 ? false : true

    }


    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 5
    }
    
    //    func onboardinPageItemRadius() -> CGFloat {
    //        return 2
    //    }
    //
    //    func onboardingPageItemSelectedRadius() -> CGFloat {
    //        return 10
    //    }
    //    func onboardingPageItemColor(at index: Int) -> UIColor {
    //        return [UIColor.white, UIColor.red, UIColor.green][index]
    //    }
}


extension OnboardingViewController: PaperOnboardingDelegate {



    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        //item.titleCenterConstraint?.constant = 100
        //item.descriptionCenterConstraint?.constant = 100
        
        // configure item
        
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}




//MARK: Constants
private extension OnboardingViewController {
    
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "Nunito-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}


