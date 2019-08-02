//
//  ViewController.swift
//  accget
//
//  Created by fukudashuichi on 2019/07/12.
//  Copyright © 2019 fukudashuichi. All rights reserved.
//


// UI 配置
// https://qiita.com/kinopontas/items/d08f84dbb711c5acbe28

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    // MotionManager
    let motionManager = CMMotionManager()
    
    // 3 axes
    @IBOutlet var accelerometerX: UILabel!
    @IBOutlet var accelerometerY: UILabel!
    @IBOutlet var accelerometerZ: UILabel!
    @IBOutlet var datelabel: UILabel!
    
    // Button
    @IBOutlet weak var button_start: UIButton!
    @IBOutlet weak var button_stop: UIButton!
    
    var loggingfilename:String  = "log01.csv"
    var inputfilename:String  = "a.csv"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタンのセットアップ
        // ボタンの装飾
        //let rgba = UIColor(red: 255/255, green: 128/255, blue: 168/255, alpha: 1.0) // ボタン背景色設定
        //button_start.backgroundColor = rgba
        button_start.layer.borderWidth = 1.0
        button_start.layer.borderColor = UIColor.blue.cgColor
        button_start.layer.cornerRadius = 10.0
        //button_start.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button_stop.layer.borderWidth = 1.0
        button_stop.layer.borderColor = UIColor.blue.cgColor
        button_stop.layer.cornerRadius = 10.0
        
        button_start.alpha=1.0
        button_stop.alpha=0.5
        button_start.isEnabled=true
        button_stop.isEnabled=false
    
        
    }
    
    func outputAccelData(acceleration: CMAcceleration){
        //現在の日付を取得
        let date:Date = Date()
        //日付のフォーマットを指定する。
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        //日付をStringに変換する
        let sDate = format.string(from: date)
        datelabel.text=sDate
        // 加速度センサー [G]
        accelerometerX.text = String(format: "%06f", acceleration.x)
        accelerometerY.text = String(format: "%06f", acceleration.y)
        accelerometerZ.text = String(format: "%06f", acceleration.z)
        
        // file write
        if let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first {
            
            let filePath = dir.appendingPathComponent( loggingfilename )
            let text: String = sDate+","+String(format: "%06f", acceleration.x)+","+String(format: "%06f", acceleration.y)+","+String(format: "%06f", acceleration.z)+"\n"
            
            
            do {
                let fileHandle = try FileHandle(forWritingTo: filePath)
                fileHandle.seekToEndOfFile()
                fileHandle.write(text.data(using: .utf8)!)
                fileHandle.closeFile()
            } catch {
                print("Error writing to file \(error)")
            }
        }

    }
    
    // センサー取得を止める場合
    func stopAccelerometer(){
        if (motionManager.isAccelerometerActive) {
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    /**
     ファイル書き込み関数定義
     
     Parameter filePath: ファイルパス名
     Returns: ファイル作成結果(true:成功/false:失敗)
     */
    func createFile(_ filePath: String) -> Bool {
        let fileManager = FileManager.default
        let result = fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        return result
    }
    
    
    // ボタン操作の関数
    @IBAction func Touch_start_bt(_ sender: Any) {
        // ボタンの表示切り替え
        button_start.alpha=0.5
        button_stop.alpha=1
        button_start.isEnabled=false
        button_stop.isEnabled=true
        
        //ファイル名の設定
        let date:Date = Date()
        let format = DateFormatter()        //日付のフォーマットを指定する。
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"        //日付をStringに変換する
        let filecreateDate = format.string(from: date)
        loggingfilename=filecreateDate+".csv"
        print("start with filename:"+loggingfilename)
        
        // ファイルの初回書き込み
        if let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first {
            
            let filePath = dir.appendingPathComponent( loggingfilename )
            do {
                let text: String = "Timestamp,x,y,z\n"
                print(text)
                try text.write(to: filePath, atomically: true, encoding: .utf8)
            } catch {
                print("error,,,¥n")
            }
        }
        // 加速度センサのセットアップ
        if motionManager.isAccelerometerAvailable {
            // intervalの設定 [sec]
            motionManager.accelerometerUpdateInterval = 0.01
            
            // センサー値の取得開始
            motionManager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                    self.outputAccelData(acceleration: accelData!.acceleration)
            })
            
        }
        
    }
    
    @IBAction func Touch_stop_bt(_ sender: Any) {
        button_start.alpha=1.0
        button_stop.alpha=0.5
        button_start.isEnabled=true
        button_stop.isEnabled=false
        
        //Show message box
        stopAccelerometer()
        showTextInputAlert()
        
        
    }
    
    func showTextInputAlert() {
        // テキストフィールド付きアラート表示
        let alert = UIAlertController(title: "保存設定", message: "ファイル名を入力してください", preferredStyle: .alert)
        // OKボタンの設定
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            // OKを押した時入力されていたテキストを表示
            if let textFields = alert.textFields {
                // アラートに含まれるすべてのテキストフィールドを調べる
                for textField in textFields {
                    print(textField.text!)
                    // file name date
                    let date:Date = Date()
                    let format = DateFormatter()        //日付のフォーマットを指定する。
                    format.dateFormat = "yyyy-MM-dd HH:mm:ss"        //日付をStringに変換する
                    let filecreateDate = format.string(from: date)
                    
                    if(textField.text?.underestimatedCount != 0){
                        self.inputfilename = textField.text!+"_"+filecreateDate+".csv"
                    }else{
                        self.inputfilename="NoName"+"_"+filecreateDate+".csv"
                    }
                }
                // ファイル名の変更処理
                do {
                    try FileManager.default.moveItem( atPath: self.loggingfilename, toPath: self.inputfilename )
                    print("saved file, "+self.inputfilename)
                } catch {print("file name change error")
                    print("Error info: \(error)")
                    print(self.loggingfilename+","+self.inputfilename)
                }
                
                
            }
        })
        alert.addAction(okAction)
        
        // キャンセルボタンの設定
        //let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //alert.addAction(cancelAction)
        // テキストフィールドを追加
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "アジ01"
        })
        // 複数追加したいならその数だけ書く
        // alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
        //     textField.placeholder = "テキスト"
        // })
        alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
    }
}
