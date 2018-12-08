//
//  ViewController.swift
//  API Gateway
//
//  Created by Victor Rocha de Oliveira on 07/12/18.
//  Copyright © 2018 Stone Tree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let client = PETPetStoreClient.default()
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.USEast1, identityPoolId: "us-east-1:318c6eef-70b3-4423-aa1b-0d45c3e05ea4")
        
        let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        
        client.petsPetIdGet(petId: "1").continueWith {(task: AWSTask) -> PETPet? in
            self.showResult(task: task)
            return nil
        }
    }

    func showResult(task: AWSTask<PETPet>) {
        if let error = task.error {
            print("Error: \(error)")
        } else if let res = task.result {
            print(String(format:"%@ %@", res.id!, res.type!))
        }
    }
}

