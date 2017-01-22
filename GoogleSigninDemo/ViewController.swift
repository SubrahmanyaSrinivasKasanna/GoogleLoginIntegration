//
//  ViewController.swift
//  GoogleSigninDemo
//
//  Created by Srinivas Kasanna on 1/22/17.
//  Copyright © 2017 citi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate,GIDSignInDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var emailID: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        (UIApplication.shared.delegate as! AppDelegate).signInCallBack = refreshInterface
        refreshInterface()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshInterface(){
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            
            signInButton.isHidden = true
            signOutButton.isHidden = false
            welcomeText.text = "Welcome, \(currentUser.profile.name.capitalized)"
            emailID.text = "Email: \(currentUser.profile.email!)"
            let profilePicURL = currentUser.profile.imageURL(withDimension: 150)
            profilePic.image = UIImage(data: NSData(contentsOf: profilePicURL!)! as Data)
            profilePic.isHidden = false
            emailID.isHidden = false
        }
        else{
            profilePic.isHidden = true
            emailID.isHidden = true
            signInButton.isHidden = false
            signOutButton.isHidden = true
            welcomeText.text = "Sign in, Stranger!!"

        }
    }

    @IBAction func didTapSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        refreshInterface()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil){
            print("Looks like we got an error \(error) ")
        }
        else{
            print("Wow you logged into the app \(user)")
            print("Wow you logged into the app \(user.profile.name)")
            refreshInterface()
            
        }
    }

}

