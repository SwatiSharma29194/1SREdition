//
//  thanksPageViewController.swift
//  Carz4Hire
//
//  Created by user on 3/15/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Stripe
class thanksPageViewController: UIViewController {
    @IBOutlet var uploadDoc: UIButton!
    var userData = UserDefaults()
    var sendDe = sendDetailsViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadDoc.setTitle("Done", for: .normal)
        
        self.uploadDoc.addTarget(self, action: #selector(self.makePayment), for: .touchUpInside)
        
//if(!(userData.value(forKey: "licence") == nil))
//{
//    if(userData.value(forKey: "licence") as! String == "have")
//    {
//    uploadDoc.setTitle("Make payment", for: .normal)
//             self.uploadDoc.addTarget(self, action: #selector(self.makePayment), for: .touchUpInside)
//    }
//    else{
//         uploadDoc.setTitle("Upload Documents", for: .normal)
//
//            self.uploadDoc.addTarget(self, action: #selector(self.makePayment), for: .touchUpInside)
//    }
//        }
//        else
//{
//
//     uploadDoc.setTitle("Upload Documents", for: .normal)
//      self.uploadDoc.addTarget(self, action: #selector(self.uploadDocuments), for: .touchUpInside)
//
//        }
        // Do any additional setup after loading the view.
    }
func uploadDocuments()
{
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "sendDetails")
    
    self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    func makePayment()
    {
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "booking")
          self.navigationController?.pushViewController(vc!, animated: false)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sendDetails") as! sendDetailsViewController
//        vc.payment = "payments"
//        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    func addCard()
    {
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
