//
//  InbrainAIViewController.swift
//  InbrainAIViewController
//
//  Created by K on 8/18/21.
//  Copyright © 2021 KWAME DARKO. All rights reserved.
//

import UIKit

import InBrainSurveys_SDK_Swift


class InbrainAIViewController: UIViewController, InBrainDelegate {

    
    
    let inBrain: InBrain = InBrain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inBrain.setInBrain(apiClientID: "fdbc4795-1e7f-44e1-805e-9b77d754ea09",
                           apiSecret: "lJtb8vI09pcBc5qjG1DHxQU1DSrjSZw9P8HBsdcFeem7L32qlarVXBqfQK9vjvM7HalSwsRZVDh5VeSef57fAA==",
                           isS2S: true)
        
        inBrain.set(userID: "userIDl")

        inBrain.inBrainDelegate = self
        inBrain.nativeSurveysDelegate = self
        inBrain.getNativeSurveys()


    }
    
    @IBAction func showInBrain(_ sender: UIButton) {
        print("LOADING SUREY")
        
        
        

        inBrain.checkForAvailableSurveys { [weak self] hasSurveys, _  in
            self?.view.isUserInteractionEnabled = true


            guard hasSurveys else {
                print("HAHAH NOOOOO WRONG")
                return
            }

            self?.inBrain.showSurveys()
        }
        

//        inBrain.showNativeSurveyWith(id: "hi")
    }
}


extension InbrainAIViewController: NativeSurveyDelegate {
    func nativeSurveysLoadingStarted() {
        //Show some activity to the user while surveys loading is in process
    }

    func nativeSurveysReceived(_ surveys: [InBrainNativeSurvey]) {
        //Cache surveys and show them to the user
    }
    
    func failedToReceiveNativeSurveys(error: Error) {
        //Handle error depends on app logic
    }

}

