//
//  CreateNewViewController.swift
//  AWSSignInPrototype
//
//  Created by Greg Hughes on 3/27/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import AWSMobileClient
var theUser : User!
class CreateNewViewController: UIViewController {

    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var retypePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    func signUp(){
        guard let emailText = emailTextField.text,
            let passwordText = passwordTextField.text,
            let retypePassword = retypePasswordTextField.text,
            let username = usernameTextField.text else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

        
        if passwordText != retypePassword {
            // Show passwords do not match alert
        }
        
        let user = User(username: username, email: emailText, uuid: UUID().uuidString, password: passwordText)
        
        
        AWSMobileClient.default().signUp(username: user.email,
                                         password: user.password,
                                         userAttributes: ["email":user.email,"custom:uuid":user.uuid]) { (signUpResult, error) in
            if let signUpResult = signUpResult {
                switch(signUpResult.signUpConfirmationState) {
                case .confirmed:
                    print("🏊🏾‍♂️ User is signed up and confirmed.")
                //TODO : Alert saying the user already exists
                case .unconfirmed:
                    
                    
                    
                    print("🚣🏼‍♂️ User is not confirmed and needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)")
                    theUser = user
                    
                    
                    
                    
                    
                case .unknown:
                    print("Unexpected case")
                }
            } else if let error = error {
                if let error = error as? AWSMobileClientError {
                    switch(error) {
                    case .usernameExists(let message):
                        print(message, " 🥇")
                         //TODO : Alert saying the user already exists
                    
                    default:
                        break
                    }
                }
                print("\(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
         signUp()
    }
    func confirmSignUp(){
    
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
