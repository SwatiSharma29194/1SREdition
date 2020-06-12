//
//  aboutusViewController.swift
//  Carz4Hire
//
//  Created by user on 3/8/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class aboutusViewController: UIViewController ,UIWebViewDelegate {
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL (string: "http://carz4hire.com/about");
        print(url)
        let requestObj = NSURLRequest(url: url! as URL);
        
        webView.loadRequest(requestObj as URLRequest)
        
        indicator.startAnimating()
        webView.delegate = self
        alert()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        
        
        
        indicator.stopAnimating()
        
        indicator.isHidden = true
        alert()
        
        
        
    }
    func alert()
        
    {
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
        }
            
        else{
            
            ////
            let alertController = UIAlertController(title: "Guardian", message: "No internet Connection", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
                
                
                
            }
            
            
            
            alertController.addAction(okAction)
            
            
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override var prefersStatusBarHidden: Bool{
    //        return true
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    @IBAction func backBtnTap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
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


