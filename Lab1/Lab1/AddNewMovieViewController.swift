//
//  AddNewMovieViewController.swift
//  Lab1
//
//  Created by Anna Berezhniak on 21.11.2020.
//  Copyright © 2020 Anna Berezhniak. All rights reserved.
//

import UIKit

protocol PassData {
    func passData(titleNew: String, typeNew: String, yearNew: String)
}

class AddNewMovieViewController: UIViewController{
    @IBOutlet weak var titleNew: UITextField!
    @IBOutlet weak var typeNew: UITextField!
    @IBOutlet weak var yearNew: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    
    var addingDelegate: PassData!
    
    @IBAction func addMovie(_ sender: Any) {
        
        if isTitleValid(title: titleNew.text!) && isTypeValid(type: typeNew.text!) && isYearValid(year: yearNew.text!) {
            
            addingDelegate.passData(titleNew: titleNew.text!, typeNew: typeNew.text!, yearNew: yearNew.text!)
            navigationController?.popViewController(animated: true)
        } else {
            errorMessage.text = "Invalid input! Please, try again)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func isTitleValid(title: String) -> Bool {
        let onlyWordsRegex = "^[a-zA-Z\\s]*$"
        let trimmedString = title.trimmingCharacters(in: .whitespaces)
        let validateTitle = NSPredicate(format: "SELF MATCHES %@", onlyWordsRegex)
        let isValidateTitle = validateTitle.evaluate(with: trimmedString)
        return isValidateTitle && !title.isEmpty
    }
    
    func isTypeValid(type: String) -> Bool {
        let wordsNumRegex = "^[a-zA-Z\\s]*$"
        let trimmedString = type.trimmingCharacters(in: .whitespaces)
        let validateType = NSPredicate(format: "SELF MATCHES %@", wordsNumRegex)
        let isValidateType = validateType.evaluate(with: trimmedString)
        return isValidateType && !type.isEmpty
    }
    
    func isYearValid(year: String) -> Bool {
        let onlyNumbersRegex = "^[0-9]*$"
        let trimmedString = year.trimmingCharacters(in: .whitespaces)
        let validateYear = NSPredicate(format: "SELF MATCHES %@", onlyNumbersRegex)
        let isValidateYear = validateYear.evaluate(with: trimmedString)
        return isValidateYear && !year.isEmpty
    }

}
