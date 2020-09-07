//
//  ViewController.swift
//  NumberToWords
//
//  Created by Gourav on 07/09/20.
//  Copyright © 2020 Gourav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtInputNumber: UITextField?
    @IBOutlet weak var lblOutputWord: UILabel?
    
    // Strings at index 0 is not used, it is to make array
    // indexing simple
    let one = ["", "one ", "two ", "three ", "four ",
               "five ", "six ", "seven ", "eight ",
               "nine ", "ten ", "eleven ", "twelve ",
               "thirteen ", "fourteen ", "fifteen ",
               "sixteen ", "seventeen ", "eighteen ",
               "nineteen " ]
    
    // Strings at index 0 and 1 are not used, they is to
    // make array indexing simple
    let ten = [ "", "", "twenty ", "thirty ", "forty ",
                "fifty ", "sixty ", "seventy ", "eighty ",
                "ninety ","","","" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtInputNumber?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        txtInputNumber?.delegate = self
        // Do any additional setup after loading the view.
    }

    @objc func textFieldDidChange(textField: UITextField)
    {
        let txtStr = textField.text ?? ""
        lblOutputWord?.text = convertToWords(n: Int64(txtStr) ?? 0)
    }
    
      // n is 1- or 2-digit number
    func numToWords(n:Int, s:String)->String
    {
          var str = ""
          // if n is more than 19, divide it
          if (n > 19) {
              let isTenArrContainIdx = ten.indices.contains(n/10)
              let tenIdx = isTenArrContainIdx == true ? n/10 : 0
              str += ten[tenIdx] + one[n % 10];
          }
          else {
              str += one[n];
          }

          // if n is non-zero
          if (n != 0) {
              str += s;
          }

          return str
    }

    func convertToWords(n:Int64)->String
    {
          // stores word representation of given number n
        var out : String = ""
        
        // handles digits at 100 billion and hundred
        // millions places (if any)
        out += numToWords(n: (Int(n / 100000000000)), s: "kharab ");
       // handles digits at 1 billion and hundred
        // millions places (if any)
        out += numToWords(n: (Int(n / 1000000000)), s: "arab ");

          // handles digits at ten millions and hundred
          // millions places (if any)
        out += numToWords(n: (Int(n / 10000000)), s: "crore ");

          // handles digits at hundred thousands and one
          // millions places (if any)
        out += numToWords(n: (Int((n / 100000) % 100)), s: "lakh ");

          // handles digits at thousands and tens thousands
          // places (if any)
        out += numToWords(n: (Int((n / 1000) % 100)), s: "thousand ");

          // handles digit at hundreds places (if any)
        out += numToWords(n: (Int((n / 100) % 10)), s: "hundred ");

          if (n > 100 && n % 100 > 0) {
              out += "and ";
          }

          // handles digits at ones and tens places (if any)
        out += numToWords(n: (Int(n % 100)), s: "");

        return out
    }
    
}

extension ViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool
    {
        let maxLength = 12
        let currentString: NSString = textField.text as NSString? ?? ""
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}

