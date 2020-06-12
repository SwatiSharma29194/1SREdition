//
//  CategoriesViewController.swift
//  Carz4Hire
//
//  Created by rv-apple on 10/03/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit


class CategoriesViewController: UIViewController {
    var vcc = dubaiPrestigeViewController()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HelicopterAction(_ sender: Any) {
//        let prestige = storyboard?.instantiateViewController(withIdentifier: "dubaiprestige") as? dubaiPrestigeViewController!
////        let getText = "Helicopter Hire"
//      prestige?.ImageText = "helicopter.jpg"
//        prestige?.cat_label = "Helicopter Hire"
//        self.navigationController?.pushViewController(prestige!, animated: false)

    }
    @IBAction func BoatAction(_ sender: Any) {
        
//        let prestige = storyboard?.instantiateViewController(withIdentifier: "dubaiprestige") as? dubaiPrestigeViewController!
//
//            prestige?.ImageText = "ship.jpg"
//            prestige?.cat_label = "Yacht hire"
//        self.navigationController?.pushViewController(prestige!, animated: false)
    }
    
    @IBAction func CoachAction(_ sender: Any) {
//        let prestige = storyboard?.instantiateViewController(withIdentifier: "dubaiprestige") as? dubaiPrestigeViewController!
//        prestige?.ImageText = "bus.jpg"
//        prestige?.cat_label = "Coach Hire"
//        self.navigationController?.pushViewController(prestige!, animated: false)
    }
    @IBAction func CartAction(_ sender: Any) {
//        let prestige = storyboard?.instantiateViewController(withIdentifier: "dubaiprestige") as? dubaiPrestigeViewController!
//         prestige?.ImageText = "cart.jpg"
//        prestige?.cat_label = "Horse and Carraige"
//        self.navigationController?.pushViewController(prestige!, animated: false)
    }
    @IBAction func WeddingAction(_ sender: Any) {
//        let prestige = storyboard?.instantiateViewController(withIdentifier: "dubaiprestige") as? dubaiPrestigeViewController!
//        prestige?.ImageText = "girl.jpg"
//        prestige?.cat_label = "Wedding Hall Hire"
//        self.navigationController?.pushViewController(prestige!, animated: false)
    }

    @IBAction func DubaiAction(_ sender: Any) {
//        let prestige = storyboard?.instantiateViewController(withIdentifier: "dubaiprestige") as? dubaiPrestigeViewController!
//         prestige?.ImageText = "lkk copy"
//        prestige?.cat_label = "Dubai Prestige"
//        self.navigationController?.pushViewController(prestige!, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func Back(_ sender: Any)
    {

            
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
