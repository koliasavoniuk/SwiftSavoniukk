//
//  IDPFacebookViewController.swift
//  IDPSwiftSavoniuk
//
//  Created by Student002 on 7/7/17.
//  Copyright © 2017 Student002. All rights reserved.
//

import UIKit

import FacebookLogin
import FacebookCore
import FBSDKLoginKit

class IDPFacebookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prepareLoginButton()
        //showEmailAddress()
        addCustomButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func prepareLoginButton () {
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }
    
    func addCustomButton() {
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40);
        
        myLoginButton.center = view.center;
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        //myLoginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
            }
        }
    }
    
    func showEmailAddress() {
        let request = GraphRequest.init(graphPath: "/me/friends")

        request.start { (response, result) in
            switch result {
            case .failed(let error):
                print("error in graph request:--------------------", error)
                break
                
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    
                    print(responseDictionary["data"] as Any)
                }
            }
            
            print("===================================== %@", result)
        }
    }
    
}
