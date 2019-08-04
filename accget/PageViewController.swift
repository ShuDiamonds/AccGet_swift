//
//  PageViewController.swift
//  accget
//
//  Created by fukudashuichi on 2019/08/03.
//  Copyright © 2019 fukudashuichi. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([getMain()], direction: .reverse, animated: true, completion: nil)
        //　最初のviewControllerを設定している
        
        self.dataSource = self
    }
    
    func getMain() -> ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //StoryBoard上のFirstViewControllerをインスタンス化している
        //withIdentifierはStoryBoard上で設定したStoryBoard Id
    }
    
    func getMonitoring() -> MonitoringViewController {
        return storyboard!.instantiateViewController(withIdentifier: "MonitoringViewController") as! MonitoringViewController
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 左に進む動き（前に戻る）
        
        if viewController.isKind(of: MonitoringViewController.self)// 現在のviewControllerがThirdViewControllerかどうか調べる
        {
            // 3 -> 2
            return getMain()
        } else {
            // 1 -> end of the road
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        // 右に進む（先に進む）
        
        if viewController.isKind(of: ViewController.self)//　現在のviewControllerがFirstViewControllerかどうか調べる
        {
            // 1 -> 2
            return getMonitoring()
            
        } else {
            // 3 -> end of the road
            return nil
        }
    }
}
