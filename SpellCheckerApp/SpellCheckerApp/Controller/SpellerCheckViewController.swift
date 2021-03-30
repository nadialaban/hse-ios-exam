//
//  SpellerCheckViewController.swift
//  SpellCheckerApp
//
//  Created by Nadia on 30.03.2021.
//

import UIKit

class SpellerCheckViewController: UIViewController,  UITextFieldDelegate {

    // MARK: -Controllers
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: -Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        wordTextField.delegate = self
    }

    // Метод для поиска ошибок
    @IBAction func onCheckWord(_ sender: Any) {
        let word: String = wordTextField.text ?? ""
        let res = MyDictionary.checkWord(word: word)
        
        resultLabel.text = res.joined(separator: "\n")
        if resultLabel.text == "" {
            resultLabel.text = "Not founded"
        }
    }
    
    // MARK: Keyboard

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }

    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
    
}
