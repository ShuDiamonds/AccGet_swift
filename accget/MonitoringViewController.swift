//
//  MonitoringViewController.swift
//  accget
//
//  Created by fukudashuichi on 2019/08/03.
//  Copyright © 2019 fukudashuichi. All rights reserved.
//

import UIKit

class MonitoringViewController: UIViewController {

    
    
    // 画像を貼るビューの宣言
    @IBOutlet weak var circle_picUI: UIImageView!
    @IBOutlet weak var activity_picUI: UIImageView!
    let circle_pic = UIImage(named:"createdpic/circle_noletter.png")!
    // 画像を貼るビューのアニメーション変数の宣言
    
    
    // activity ごとの写真を格納
    let pic_waiting2 = UIImage(named:"createdpic/waiting2.png")!
    let pic_hitting = UIImage(named:"createdpic/hitting.png")!
    let pic_moving = UIImage(named:"createdpic/moving.png")!
    let pic_casting = UIImage(named:"createdpic/casting.png")!
    let pic_windingreel = UIImage(named:"createdpic/winding_reel.png")!
    
    var pic_array : [UIImage] = []//= [pic_waiting2,pic_moving,pic_moving,pic_casting,pic_waiting2]

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        circle_picUI.image=circle_pic
        activity_picUI.image=pic_waiting2
        
        //animation add
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        // 起点を0度とする
        rotateAnimation.fromValue = 0.0
        // 終点を360度とする
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        // 2秒で1回転
        rotateAnimation.duration = 20.0
        // 永遠に回転
        rotateAnimation.repeatCount = .infinity
        // アニメーションを追加
        circle_picUI.layer.add(rotateAnimation, forKey: nil)
        
        
        //
        pic_array.append(pic_waiting2)
        pic_array.append(pic_moving)
        pic_array.append(pic_moving)
        pic_array.append(pic_casting)
        pic_array.append(pic_waiting2)
        
        // タイマー処理の記述
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MonitoringViewController.timerUpdate), userInfo: nil, repeats: true)
    }
    
    var i = 0
    @objc func timerUpdate() {
        // animation ref : https://qiita.com/hachinobu/items/57d4c305c907805b4a53
        UIView.transition(with: activity_picUI, duration: 0.8, options: [.transitionFlipFromLeft], animations: nil, completion: nil)
        activity_picUI.image=pic_array[i]
        
        i=i+1
        if(i == pic_array.count){
            i=0
        }
        
        print("update"+String(i))
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
