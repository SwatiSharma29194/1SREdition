//
//  cardDetailsViewController.swift
//  Carz4Hire
//
//  Created by user on 3/6/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class cardDetailsViewController: UIViewController
{
    var getDictc = NSDictionary()
    var getCardId = Int()
    @IBOutlet var yeartxt: UILabel!
    @IBOutlet var nametxt: UILabel!
    @IBOutlet var cardnumbertxt: UILabel!
    var connection = webservices()
    var message = ""
    var userData = UserDefaults()
    @IBOutlet var cardtypetext: UILabel!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        print(getDictc)
        getCardId = getDictc.value(forKey: "getcardId") as! Int
        
        cardnumbertxt.text = getDictc.value(forKey: "getcardnumber") as! String
        yeartxt.text = getDictc.value(forKey: "getexpyear") as! String
        nametxt.text = getDictc.value(forKey: "getname") as! String
        cardtypetext.text = getDictc.value(forKey: "getcardtype") as! String
     
    }
    @IBAction func deketeBtnTap(_ sender: Any) {
        
        deleteCard()
    }

    func deleteCard(){
        IJProgressView.shared.showProgressView(view: self.view)
        var param = [NSString: NSObject]()
        param = ["card_id":getCardId as NSObject]
        
        print(param)
        connection.startConnectionWithSting2(getUrlString: "deletecard", method_type: methodType.POST, params: param, outputBlock: { (receivedData) in
        
        
            
            if (self.connection.responseCode == 1){
                
                print(receivedData)
                
                if(!((receivedData.value(forKey: "message") == nil)))
                {
                    if(receivedData.value(forKey: "message") as! String == "success")
                    {
                        
                     
                        IJProgressView.shared.hideProgressView()
          
                        let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Card deleted", preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "myaccount")
                            self.userData.set("card", forKey: "getTypeSeg")
                            self.navigationController?.pushViewController(vc!, animated: false)
//                            self.navigationController?.popViewController(animated: true)
                            
                        }
                        
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                        
                        
                    else{
                        
                        
                        
                        
                        
                        //  print(message)
                        
                        self.message = receivedData.value(forKey: "message") as! String
                        
                        
                        print(receivedData)
                        
                        
                        
                        let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: self.message, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            IJProgressView.shared.hideProgressView()
                            
                        }
                        
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    }
                    
                    
                }
                    
                    
                    //                    if((receivedData.value(forKey: "status") as! Int) == 0){
                    //
                    //
                    //                    }
                else{
                    
                    
                    
                    
                    
                    //  print(message)
                    
                    
                    
                    
                }
                
            }
            else{
                
                print(receivedData)
                
                
                let alertController = UIAlertController(title: "1 STOP CAR RENTALS", message: "Connection Error", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    IJProgressView.shared.hideProgressView()
                    
                   self.deleteCard()
                    
                    
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                    UIAlertAction in
                    
                    IJProgressView.shared.hideProgressView()
                }
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
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
