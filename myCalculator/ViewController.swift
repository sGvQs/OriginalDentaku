//
//  ViewController.swift
//  myCalculator
//
//  Created by Susumu Goto on 2021/10/06.
//

/*
 
 フローチャート（改良版）enum仕様
 
 1. 1.1~9の数字ボタンそれぞれに適正なアクションを追加する
    ->outletでtapNumbersに接続
    ->それぞれのボタンに適切なtagをつける
    ->ボタンを押した時にtagの数字が表示される処理を施す
    ->tapNumbersが連続で押された場合、新たに押された数字は後ろにくっ付く
 
 2. 符号が押された時のアクションを追加
    ->enumを作る(Hugou)
        ->どの符号ボタンが押されたのかを検出するシステム
    ->それぞれの符号をoutletで接続
    ->それぞれのoutlet内でenumの材料を作成
    ->変数savingNumberを作成
        ->数字が入力されてから符号ボタンが押された時に表示されている数字をsavingNumberに保存する処理
    ->変数finalNumberを作成
        -> finalNumber = savingNumber (Hugou) 入力されている数字
   
3. 新たな数字が表示されている状態で＝ボタンが押された場合
    ->計算を実行
    ->計算結果を表示
    ->savingNumberをnilに変更
    ->結果が表示されたのち、結果(finalNumber)をsavingNumberにすり替える (finalNumber = savingNumber)
 
 3.　CAボタンで全てのデータをリセット
    ->変数savingNumberの中身をnilに変換
    ->変数finalNumberの中身をnilに変換
    ->表示されている数字も""に変換
    
 **/

import UIKit

class ViewController: UIViewController {
    
    var savingNumberString: String?
    var finalNumeberString: String?
    var doingMath = false
    
    enum Hugou {
        case plus
        case multiple
        case slash
        case minos
    }
    var hugou: Hugou?

    @IBOutlet weak var resultText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapNumbers(_ sender: UIButton) {
        
            if resultText.text == nil {
                resultText.text = String(sender.tag)
            } else {
                resultText.text! += String(sender.tag)
            }
    }
    
    func reset() {
        resultText.text = ""
    }
        
    @IBAction func tapSlash(_ sender: UIButton) {
        hugou = .slash
        savingNumberString = resultText.text
        doingMath = true
        reset()
    }
    
    @IBAction func tapMultiple(_ sender: UIButton) {
        hugou = .multiple
        savingNumberString = resultText.text
        doingMath = true
        reset()
    }
    
    @IBAction func tapMinos(_ sender: UIButton) {
        hugou = .minos
        savingNumberString = resultText.text
        doingMath = true
        reset()
    }
    
    @IBAction func tapPlus(_ sender: UIButton) {
        hugou = .plus
        savingNumberString = resultText.text
        doingMath = true
        reset()
    }
    
    @IBAction func deleteOne(_ sender: UIButton) {
        
        guard let text = resultText.text else {
            return
        }
        resultText.text = text.dropLast().description
    }
    
    @IBAction func tapFinal(_ sender: UIButton) {
        
        guard let hugou = hugou else {
            return
        }
        
        if doingMath {
            
            finalNumeberString = resultText.text
            
            guard let sns = savingNumberString else {
                return print("savingNumberString is not right")
            }
            
            guard let savingNumberDouble = Double(sns) else {
                return
            }

            guard let fns = finalNumeberString else {
                return print("finalNumberString is not right")
            }
            
            guard let finalNumberDouble = Double(fns) else {
                return
            }
            
            let resultTextNumber: Double = {
                switch hugou {
                case .slash: return savingNumberDouble / finalNumberDouble
                case .multiple: return savingNumberDouble * finalNumberDouble
                case .minos: return savingNumberDouble - finalNumberDouble
                case .plus: return savingNumberDouble + finalNumberDouble
                }
            }()
            
            resultText.text = String(resultTextNumber)
            
            if resultTextNumber >= 10000000 {
                resultText.text = "Error"
            } 
        }
    }
    
    @IBAction func caBotton(_ sender: UIButton) {
        savingNumberString = nil
        finalNumeberString = nil
        doingMath = false
        resultText.text = nil
    }
    
}
