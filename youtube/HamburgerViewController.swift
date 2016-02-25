//
//  HamburgerViewController.swift
//  youtube
//
//  Created by Fremling, Alicia (Contractor) on 2/24/16.
//  Copyright © 2016 FargoFremling. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    
    var initialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController")
        
        feedViewController = storyboard.instantiateViewControllerWithIdentifier("FeedViewController")
        
        feedViewController.view.frame = feedView.frame
        feedView.addSubview(feedViewController.view)
        
        menuViewController.view.frame = menuView.frame
        menuView.addSubview(menuViewController.view)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            initialCenter = feedView.center
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.menuView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            })
            
        }
            
        else if sender.state == UIGestureRecognizerState.Changed {
            feedView.center = CGPoint (x: translation.x + initialCenter.x, y: initialCenter.y)
        }
            
        else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                if velocity.x < 0 {
                    self.feedView.center = self.view.center
                }
                else {
                    self.feedView.center = CGPoint(x: self.view.center.x + 270, y: self.view.center.y)
                }
                }, completion: { (Bool) -> Void in
                    self.menuView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
