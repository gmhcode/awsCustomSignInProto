//
//  ViewController.swift
//  AWSSignInPrototype
//
//  Created by Greg Hughes on 3/26/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import AWSMobileClient
class ViewController: UIViewController {
    
    
    @IBOutlet weak var signInStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                switch(userState){
                case .signedIn:
                    DispatchQueue.main.async {
                        AWSMobileClient.default().signOut()
                        self.signInStateLabel.text = "Logged In"
                    }
                case .signedOut:
                    //                           AWSMobileClient.default().showSignIn(navigationController: self.navigationController!, { (userState, error) in
                    //                                   if(error == nil){       //Successful signin
                    //                                       DispatchQueue.main.async {
                    //                                           self.signInStateLabel.text = "Logged In"
                    //                                       }
                    //                                   }
                    //                               })
                                            AWSMobileClient.default().showSignIn(navigationController: self.navigationController!, { (signInState, error) in
                                                if let signInState = signInState {
                                                    print("Sign in flow completed: \(signInState)")
                                                } else if let error = error {
                                                    print("error logging in: \(error.localizedDescription)")
                                                }
                                            })
                                            
//                    AWSMobileClient.default()
//                        .showSignIn(navigationController: self.navigationController!,
//                                    signInUIOptions: SignInUIOptions(
//                                        canCancel: false,
//                                        logoImage: UIImage(named: "MyCustomLogo"),
//                                        backgroundColor: UIColor.black)) { (result, err) in
//                                            //handle results and errors
//                    }
                default:
                    AWSMobileClient.default().signOut()
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
//        newUser()
    }
    func newUser(){
        AWSMobileClient.default().signUp(username: "your_username",
                                                password: "Abc@123!",
                                                userAttributes: ["email":"john@doe.com", "phone_number": "+1973123456"]) { (signUpResult, error) in
            if let signUpResult = signUpResult {
                switch(signUpResult.signUpConfirmationState) {
                case .confirmed:
                    print("User is signed up and confirmed.")
                case .unconfirmed:
                    print("User is not confirmed and needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)")
                case .unknown:
                    print("Unexpected case")
                }
            } else if let error = error {
                if let error = error as? AWSMobileClientError {
                    switch(error) {
                    case .usernameExists(let message):
                        print(message)
                    default:
                        break
                    }
                }
                print("\(error.localizedDescription)")
            }
        }
    }
    
}

