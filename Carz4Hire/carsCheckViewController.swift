//
//  carsCheckViewController.swift
//  Carz4Hire
//
//  Created by user on 3/8/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class carsCheckViewController: UIViewController {

    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "carsDetail")
            
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
