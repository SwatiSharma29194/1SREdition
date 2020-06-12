//
//  carDetailsViewController.swift
//  Carz4Hire
//
//  Created by user on 3/8/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class carDetailsViewController: UIViewController {

  
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var carImg: UIImageView!
    var imagesCar = ["bg_image copy.png","pexels-photo-170811.jpeg","car-images-download.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func pageControlTap(_ sender: UIPageControl) {
        
        if(pageControl.currentPage == 0)
        {
            carImg.image = UIImage(named: "bg_image copy.png")
        }
        if(pageControl.currentPage == 1)
        {
            carImg.image = UIImage(named:"pexels-photo-170811.jpeg")
        }
        
        else
        {
            carImg.image = UIImage(named: "car-images-download.jpg")
        }
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
