//
//  LoginViewController.swift
//  LoginKit
//
//  Created by Mickael on 26/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit
import MaterialComponents
import Firebase

class LoginViewController: UIViewController {
    
    var allConstraints: [NSLayoutConstraint] = []
    var views = [String : Any]()
    
    let logoImageView: UIImageView = {
        let baseImage = UIImage.init(named: "Logo")
        //let templatedImage = baseImage?.withRenderingMode(.alwaysTemplate)
        let logoImageView = UIImageView(image: baseImage)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    var mailTextField: MDCTextField = {
        let mailTextField = MDCTextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.clearButtonMode = .unlessEditing
        mailTextField.autocapitalizationType = .none
        return mailTextField
    }()
    
    let passwordTextField: MDCTextField = {
        let passwordTextField = MDCTextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    let registerButton: MDCFlatButton = {
        let cancelButton = MDCFlatButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Register", for: .normal)
        cancelButton.addTarget(self, action: #selector(didTapRegister(sender:)), for: .touchUpInside)
        return cancelButton
    }()
    
    let loginButton: MDCRaisedButton = {
        let nextButton = MDCRaisedButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Log in", for: .normal)
        nextButton.addTarget(self, action: #selector(didTapLogin(sender:)), for: .touchUpInside)
        return nextButton
    }()
    
    let mailTextFieldController: MDCTextInputControllerOutlined
    let passwordTextFieldController: MDCTextInputControllerOutlined
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        mailTextFieldController = MDCTextInputControllerOutlined(textInput: mailTextField)
        passwordTextFieldController = MDCTextInputControllerOutlined(textInput: passwordTextField)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        mailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        //add(subview: titleLabel, key: "title")
        add(subview: logoImageView, key: "logoImage")
        add(subview: mailTextField, key: "mail")
        add(subview: passwordTextField, key: "password")
        add(subview: loginButton, key: "loginButton")
        add(subview: registerButton, key: "registerButton")
        mailTextFieldController.placeholderText = "Mail"
        passwordTextFieldController.placeholderText = "Password"
        mailTextField.delegate = self
        passwordTextField.delegate = self
        createConstraints()
        NSLayoutConstraint.activate(allConstraints)
    }
    
    private func add(subview: UIView, key: String) {
        view.addSubview(subview)
        views[key] = subview
    }
    
    private func createConstraints() {
        
        let usernameTextFieldConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[mail]-15-|",
            metrics: nil,
            views: views)
        allConstraints += usernameTextFieldConstraint
        
        let passwordTextFieldConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[password]-15-|",
            metrics: nil,
            views: views)
        allConstraints += passwordTextFieldConstraint
        
        let logoImageConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[logoImage(150)]",
            metrics: nil,
            views: views)
        allConstraints += logoImageConstraint
        
        allConstraints.append(NSLayoutConstraint(item: logoImageView,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: logoImageView,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 0))
        
        let verticalTextFieldsConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-40-[logoImage]-15-[mail]-15-[password]",
            options: .alignAllCenterX,
            metrics: nil,
            views: views)
        allConstraints += verticalTextFieldsConstraint
        
        allConstraints.append(NSLayoutConstraint(item: registerButton,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: passwordTextField,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: 8))
        
        let alignButtonsConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[registerButton]-[loginButton]-|",
            options: .alignAllCenterY,
            metrics: nil,
            views: views)
        allConstraints += alignButtonsConstraint
    }
    
    @objc func didTapLogin(sender: Any) {
        signin()
    }
    
    private func signin() {
        guard
            let email = mailTextField.text,
            let password = passwordTextField.text,
            email.count > 0,
            password.count > 0
            else {
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                print(error.localizedDescription)
                self.signinAlert(error)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func signinAlert(_ error: Error) {
        let alert = UIAlertController(title: "Sign In Failed", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapRegister(sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}

