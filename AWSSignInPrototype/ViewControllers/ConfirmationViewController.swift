//
//  ConfirmationViewController.swift
//  AWSSignInPrototype
//
//  Created by Greg Hughes on 3/27/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import AWSMobileClient
class ConfirmationViewController: UIViewController {

    @IBOutlet weak var confirmTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkConfirmationNumber(){
        AWSMobileClient.default().confirmSignUp(username: "your_username", confirmationCode: confirmTextField.text!) { (signUpResult, error) in
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
                     print("\(error.localizedDescription)")
                 }
             }
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
