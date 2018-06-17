//
//  ViewController.swift
//  ExpKeyboardTransition
//
//  Created by Mischa (Privat) on 6/17/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = self
        modalPresentationStyle = .custom
        registerForKeyboardNotifications()
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: Notification.Name.UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        textField?.becomeFirstResponder()
    }
    
    @IBAction func toggleInputAccessoryView(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            textField?.inputAccessoryView = UIView()
        case false:
            textField?.inputAccessoryView = nil
        }
        textField?.resignFirstResponder()
        textField?.becomeFirstResponder()
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {}
    
    @objc func keyboard(notification: Notification) {
        print(notification.name.rawValue)
    }

    @objc func keyboardWillShow(notification: Notification) {
        print(notification.name.rawValue)
        
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        bottomConstraint.constant = keyboardFrame.size.height
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        print(notification.name.rawValue)

        bottomConstraint.constant = 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "unwind" {
            print("\n⬅️ Unwind segue.\n")
        } else {
            print("\n➡️ Perform segue.\n")
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
    
}

