//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        //IBOutletsによる全てのボタンの選択解除
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //IBActionのトリガーとなったボタンを選択状態にする
        sender.isSelected = true
        
        //押されたボタンの現在のタイトルの取得(currenttitle)
        let buttonTitle = sender.currentTitle!
        //  ↓             ↓
        //タイトルから(%)を取り除き文字列に戻す
        let butttonTitlePercentString = String(buttonTitle.dropLast())
        //  ↓             ↓
        //その後Doubleに変換
        let buttonTitleAsNumber = Double(butttonTitlePercentString)!
        
        
        tip = buttonTitleAsNumber / 100
        
        
        

    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //ステッパーの値を取得し//整数へ切り捨て
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        //  ↓             ↓
        //整数として設定
        numberOfPeople = Int(sender.value)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
         
          //テキストが空文字ではない場合は""
        if bill != "" {
            
            //小数点以下の桁数を持つ実際の文字列に変換
            billTotal = Double(bill)!
            
              //請求書にチップの割合をかけ人数で割って請求書を分割する
             let result = billTotal * (1 + tip) / Double(numberOfPeople)
            //  ↓             ↓
            //結果を小数点以下２桁に丸めStringに丸める
            finalResult = String(format: "%.2f", result)
        }
        
        //segue(goToResults)を発生させるトリガーとなる
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }///@IBAction func calculatePressed
    //segueが始まる直前にトリガーされる
                          //ここはテンプレート
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //現在トリガーされているsegueが"goToResult"の場合
        if segue.identifier == "goToResults" {
            
            //配信先VCのインスタンスを取得しResultsViewControllerへタイプキャストする
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
        
}
    
   

