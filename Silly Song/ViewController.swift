//
//  ViewController.swift
//  Silly Song
//
//  Created by Christopher Sim on 11/12/17.
//  Copyright © 2017 Christopher Sim. All rights reserved.
//

import UIKit

func shortNameFromName(name: String) -> String {
    
    var lowercaseName = name.lowercased()
    lowercaseName = lowercaseName.folding(options: .diacriticInsensitive, locale: nil)
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    
    if let firstVowelRange = name.rangeOfCharacter(from: vowelSet, options: .caseInsensitive) {
        
        return lowercaseName.substring(from: firstVowelRange.lowerBound)
    }
    // no vowels = return the full name
    return lowercaseName
}


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    
    let shortName = shortNameFromName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")




class ViewController: UIViewController {


    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        self.nameField.text = ""
        self.lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        self.lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: self.nameField.text!)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
