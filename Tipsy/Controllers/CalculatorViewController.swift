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
    @IBOutlet weak var zeroPctButton:UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!


    var tip = 0.0
    // to use this app remember, you must have a minimum of 2 people! if course this variable may change //
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    

    @IBAction func tipChanged(_ sender: UIButton) {

        tenPctButton.isSelected = false
        zeroPctButton.isSelected = false
        twentyPctButton.isSelected = false

        
        sender.isSelected = true

     let buttonTitle = sender.currentTitle!
        // this will remove the percentage sign from the data //
        let buttonTitleMinusPercentage =  String(buttonTitle.dropLast())


        // this will change the button title from a string to a double data type //
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentage)!
        // this will change it into a decimal //
        tip = buttonTitleAsANumber / 100

        billTextField.endEditing(true)

    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // this will increase and decrease the stepper value //
         splitNumberLabel.text = String(format: "%.0f", sender.value)

         numberOfPeople = Int(sender.value)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
// the following code within the function is used to calculate the bill //
        let bill = billTextField.text!
        
        if bill != "" {
                 
                 //Turn the bill from a String e.g. "123.50" to an actual String with decimal places.
                 //e.g. 125.50
                 billTotal = Double(bill)!
                 
                 //Multiply the bill by the tip percentage and divide by the number of people to split the bill.
                 let result = billTotal * (1 + tip) / Double(numberOfPeople)
                 
                 //Round the result to 2 decimal places and turn it into a String.
                  finalResult = String(format: "%.2f", result)
            
             }
        
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
        

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToResult" {
                let destinationVC = segue.destination as! ResultsViewController
                
                
                
                //Set the destination ResultsViewController's properties.
                destinationVC.result = finalResult
                destinationVC.tip = Int(tip * 100) // changes it into a percentage
                destinationVC.split = numberOfPeople
            }
            
        }
    

}



