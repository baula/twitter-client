//
//  PostViewController.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/30/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var captionLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

    @IBAction func onPost(sender: AnyObject) {

        let dict: NSDictionary = ["status": captionLabel.text!]
        
        self.dismissViewControllerAnimated(false, completion: nil)
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
