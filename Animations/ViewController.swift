//
//  ViewController.swift
//  Animations
//
//  Created by Armando Silveira on 3/14/17.
//  Copyright © 2017 Armando Silveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet var loginView: UIView!
    
    var originalEffect: UIVisualEffect!
    
    
    var loginViewMovedUp: Bool = false
    
    @IBOutlet weak var vEffect: UIVisualEffectView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // save the blur effect and then negate it
        originalEffect = vEffect.effect
        vEffect.effect = nil
        
        loginView.layer.cornerRadius = 5
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animateIn() {
        // add the login view.
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        loginView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.vEffect.effect = self.originalEffect
            self.loginView.alpha = 1
            self.loginView.transform = CGAffineTransform.identity
        })
    
    }
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.loginView.transform = CGAffineTransform(scaleX: 1.3, y:1.3)
            self.loginView.alpha = 0
            self.vEffect.effect = nil
        }, completion: { _ in
            self.loginView.removeFromSuperview()
            self.loginViewMovedUp = false
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.loginView.transform = CGAffineTransform(scaleX: 1.3, y:1.3)
            self.loginView.alpha = 0
            self.vEffect.effect = nil
        })
    }
    
    @IBAction func onCancel_click(_ sender: Any) {
        animateOut()
    }
    
    @IBAction func handleAction(recognizer: UIPinchGestureRecognizer) {
        if recognizer.scale < 1 {// pinching in
            // if the login view has been placed into the main view.
            //
            if !self.loginView.isDescendant(of: self.view) {
                animateIn()
            }
        
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if !loginViewMovedUp {
            UIView.animate(withDuration: 2, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
                
                self.loginView.frame.origin.y -= 50
                self.loginViewMovedUp = true
                
            }, completion: nil)
            
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if loginViewMovedUp {
            UIView.animate(withDuration: 2, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
            
            self.loginView.frame.origin.y += 50
            self.loginViewMovedUp = false
            
            }, completion: nil)
        }
        
    }
    
    @IBAction func login(_ sender: Any) {
        if self.username.text == "user" && self.password.text == "pass" {
            // move the box to the above the view and then remove the login view.
            
            // my code
            UIView.animate(withDuration: 2, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
                
                self.loginView.frame.origin.y -= 1000
                
            }, completion: nil)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.loginView.transform = CGAffineTransform(scaleX: 1.3, y:1.3)
 
            }, completion: { _ in
                self.loginView.removeFromSuperview()

            })
            loginViewMovedUp = false
            
        } else {
            shake()
        }
    }
    
    // Core animations!!!!
    func shake() {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = 3
        animation.duration = 0.07
        animation.autoreverses = true
        animation.byValue = 7
        self.loginView.layer.add(animation, forKey: "position")
    }
    

}

