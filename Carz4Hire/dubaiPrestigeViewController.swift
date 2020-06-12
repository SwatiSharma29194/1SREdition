//
//  dubaiPrestigeViewController.swift
//  Carz4Hire
//
//  Created by user on 3/9/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class dubaiPrestigeViewController: UIViewController {

    @IBOutlet var Label: UILabel!
    
    @IBOutlet var label2: UILabel!
    
    @IBOutlet var ImageView: UIImageView!
    
    var ImageText : String!
    var cat_label : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ImageView.image = UIImage(named: ImageText)
        label2.text = cat_label
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func BackToCategory(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: false)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
