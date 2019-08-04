//
//  MonitoringViewController.swift
//  accget
//
//  Created by fukudashuichi on 2019/08/03.
//  Copyright © 2019 fukudashuichi. All rights reserved.
//

import UIKit

class MonitoringViewController: UIViewController {

    
    
    @IBOutlet weak var circle_picUI: UIImageView!
    @IBOutlet weak var activity_picUI: UIImageView!
    let circle_pic = UIImage(named:"createdpic/circle_noletter.png")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        circle_picUI.image=circle_pic
        let activity_pic = UIImage(named:"createdpic/waiting2.png")!
        activity_picUI.image=activity_pic
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
