//
//  MenuViewController.swift
//  RiseOfTheRacer
//
//  Created by igmstudent on 11/21/15.
//  Copyright © 2015 BigTipperGames. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var PlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        PlayButton.backgroundColor = UIColor.clearColor()
        PlayButton.layer.cornerRadius = 5
        PlayButton.layer.borderWidth = 1
        PlayButton.layer.borderColor = UIColor.redColor().CGColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlayPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("ToGame", sender: nil)
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
