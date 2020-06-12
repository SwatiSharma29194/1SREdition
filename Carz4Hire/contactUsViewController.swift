//
//  contactUsViewController.swift
//  Carz4Hire
//
//  Created by user on 3/9/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import MessageUI
class contactUsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet var address: UILabel!
    @IBOutlet var number: UnderlinedLabel!
    @IBOutlet var site: UIButton!
    @IBOutlet var email: UnderlinedLabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        email.text = "1stoprentals@mail.com"
         number.text = "01204777200"
//        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
//        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
//        myLabel.attributedText = underlineAttributedString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBtnTap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func loadSite(_ sender: Any) {
        guard let url = URL(string: "https://www.1srhire.com") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    @IBAction func btnMail(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        

    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["1stoprentals@mail.com"])
        mailComposerVC.setSubject("ISR")
        mailComposerVC.setMessageBody("1SR", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//
//        controller.dismiss(animated: true, completion: nil)
//    }
    @IBAction func call(_ sender: Any) {
        
         let phoneNumber = "01204777200"
        
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
//
//        var editedPhoneNumber = ""
//        if phoneNumber != "" {
//
//            for i in phoneNumber.characters {
//
//                switch (i){
//                case "+","0","1","2","3","4","5","6","7","8","9" : editedPhoneNumber = editedPhoneNumber + String(i)
//                default : break
//
//                }
//            }
//
//            let phone = "tel://" + editedPhoneNumber
//            let url = NSURL(string: phone)
//            if let url = url {
//                UIApplication.shared.openURL(url as URL)
//                print(url)
//            } else {
//                print("There was an error")
//            }
//        } else {
//
//        }
        
     
    }
    func call(phoneNumber: String) -> Bool {
        var editedPhoneNumber = ""
        if phoneNumber != "" {
            
            for i in phoneNumber.characters {
                
                switch (i){
                case "+","0","1","2","3","4","5","6","7","8","9" : editedPhoneNumber = editedPhoneNumber + String(i)
                default : break
                    
                }
            }
            
            let phone = "tel://" + editedPhoneNumber
            let url = NSURL(string: phone)
            if let url = url {
                UIApplication.shared.openURL(url as URL)
                print(url)
            } else {
                print("There was an error")
            }
        } else {
            return false
        }
        
        return true
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
class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
