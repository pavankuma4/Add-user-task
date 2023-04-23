//
//  FinalViewController.swift
//  Add Users intf
//
//  Created by user238064 on 4/3/23.
//

import UIKit

class FinalViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var education: UITextField!
    @IBOutlet weak var dateAndTime: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var slider: UISlider!

    
    @IBOutlet var allSquares: [UIButton]!
    @IBOutlet var allStars: [UIButton]!
    @IBOutlet weak var submitSelected: UIButton!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var updatedText = ""
        if textField == name{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        }
        return updatedText.count <= 40
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    func displayAlertMessage(messagetoDisplay: String){
        let alertController = UIAlertController(title: "Alert", message: messagetoDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            print("Ok button tapped");
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    @IBAction func dobcal(_ sender: UIButton) {
        let pickdate : UIDatePicker = UIDatePicker()
        pickdate.datePickerMode = .date
        pickdate.addTarget(self, action: #selector(dueDateChanged(picker:)), for: UIControl.Event.valueChanged)
        pickdate.frame.size = CGSize(width: 0, height: 50)
        self.view.addSubview(pickdate)
        dob.inputView = pickdate
        dob.text = formateDate(date: pickdate.date)
    }
    @objc func dueDateChanged(picker: UIDatePicker){
        dob.text = formateDate(date: picker.date)
    }
    func formateDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func dateAndTimeBut(_ sender: UIButton) {
        let pickdat : UIDatePicker = UIDatePicker()
        pickdat.datePickerMode = .dateAndTime
        pickdat.addTarget(self, action: #selector(dueDateChanged2(pickdat:)), for: UIControl.Event.valueChanged)
        pickdat.frame.size = CGSize(width: 0, height: 50)
        self.view.addSubview(pickdat)
        dateAndTime.inputView = pickdat
        dateAndTime.text = formateDate2(date: pickdat.date)
    }
    @objc func dueDateChanged2(pickdat: UIDatePicker){
        dateAndTime.text = formateDate2(date: pickdat.date)
    }
    func formateDate2(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy | hh:mm"
        return formatter.string(from: date)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        email.delegate = self
        dob.delegate = self
        dateAndTime.delegate = self
        education.delegate = self
    }
    @IBAction func squarePressed(_ sender: UIButton) {
        for btn in allSquares{
            if btn.tag == sender.tag{
                btn.setImage(UIImage(named: "Component 41 – 8"), for: .normal)
            }else{
                btn.setImage(UIImage(named: "Rectangle 3754"), for: .normal)
            }
        }
    }
    @IBAction func starButton(_ sender: UIButton) {
        for button in allStars{
            if button.tag <= sender.tag{
                button.setImage(UIImage(named: "star-symbol-icon-1"), for: .normal)
            }
            else{
                button.setImage(UIImage(named: "star-half-yellow-icon"), for: .normal)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitSelected(_ sender: UIButton) {
        guard let providedEmailAddress = email.text else { return  }
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: providedEmailAddress)
        if isEmailAddressValid{
            print("Email address is valid")
        }
        else{
            print("Email adress is not valid")
            displayAlertMessage(messagetoDisplay: "Email adress is not valid ")
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        slider.value = roundf(slider.value )
        
    }
    
}
