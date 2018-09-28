//
//  RegisterViewController.swift
//  LoginKit
//
//  Created by Mickael on 26/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit
import MaterialComponents
import Firebase

class RegisterViewController: UIViewController {

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
    
    let usernameTextField: MDCTextField = {
        let usernameTextField = MDCTextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.autocapitalizationType = .none
        return usernameTextField
    }()
    
    let harbourTextField: MDCTextField = {
        let harbourTextField = MDCTextField()
        harbourTextField.translatesAutoresizingMaskIntoConstraints = false
        harbourTextField.autocapitalizationType = .none
        return harbourTextField
    }()
    
    let boatTextField: MDCTextField = {
        let boatTextField = MDCTextField()
        boatTextField.translatesAutoresizingMaskIntoConstraints = false
        boatTextField.autocapitalizationType = .none
        return boatTextField
    }()
    
    let cancelButton: MDCFlatButton = {
        let cancelButton = MDCFlatButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(didTapCancel(sender:)), for: .touchUpInside)
        return cancelButton
    }()
    
    let signupButton: MDCRaisedButton = {
        let nextButton = MDCRaisedButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Sign up", for: .normal)
        nextButton.addTarget(self, action: #selector(didTapSignup(sender:)), for: .touchUpInside)
        return nextButton
    }()
    
    let mailTextFieldController: MDCTextInputControllerOutlined
    let passwordTextFieldController: MDCTextInputControllerOutlined
    let usernameTextFieldController: MDCTextInputControllerOutlined
    let harbourTextFieldController: MDCTextInputControllerOutlined
    let boatTextFieldController: MDCTextInputControllerOutlined
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        mailTextFieldController = MDCTextInputControllerOutlined(textInput: mailTextField)
        passwordTextFieldController = MDCTextInputControllerOutlined(textInput: passwordTextField)
        usernameTextFieldController = MDCTextInputControllerOutlined(textInput: usernameTextField)
        harbourTextFieldController = MDCTextInputControllerOutlined(textInput: harbourTextField)
        boatTextFieldController = MDCTextInputControllerOutlined(textInput: boatTextField)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        add(subview: logoImageView, key: "logoImage")
        add(subview: mailTextField, key: "mail")
        add(subview: passwordTextField, key: "password")
        add(subview: usernameTextField, key: "username")
        add(subview: harbourTextField, key: "harbour")
        add(subview: boatTextField, key: "boat")
        add(subview: signupButton, key: "signupButton")
        add(subview: cancelButton, key: "cancelButton")
        mailTextFieldController.placeholderText = "Mail"
        passwordTextFieldController.placeholderText = "Password"
        usernameTextFieldController.placeholderText = "Username"
        harbourTextFieldController.placeholderText = "Harbour"
        boatTextFieldController.placeholderText = "Boat"
        mailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        harbourTextField.delegate = self
        boatTextField.delegate = self
        createConstraints()
        NSLayoutConstraint.activate(allConstraints)
    }
    
    private func add(subview: UIView, key: String) {
        view.addSubview(subview)
        views[key] = subview
    }
    
    private func createConstraints() {
        let usernameTextFieldConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[username]-15-|",
            metrics: nil,
            views: views)
        allConstraints += usernameTextFieldConstraint
        
        let passwordTextFieldConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[password]-15-|",
            metrics: nil,
            views: views)
        allConstraints += passwordTextFieldConstraint
        
        let mailTextFieldConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[mail]-15-|",
            metrics: nil,
            views: views)
        allConstraints += mailTextFieldConstraint
        
        let harbourTextFieldConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[harbour]-15-|",
            metrics: nil,
            views: views)
        allConstraints += harbourTextFieldConstraint
        
        let boatTextFieldConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[boat]-15-|",
            metrics: nil,
            views: views)
        allConstraints += boatTextFieldConstraint
        
        let logoImageConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[logoImage(150)]",
            metrics: nil,
            views: views)
        allConstraints += logoImageConstraint
        
        allConstraints.append(NSLayoutConstraint(item: logoImageView,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .centerX,
                                                 multiplier: 1,
                                                 constant: 0))
        
        allConstraints.append(NSLayoutConstraint(item: logoImageView,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: logoImageView,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 0))
        
        allConstraints.append(NSLayoutConstraint(item: logoImageView,
                                                 attribute: .top,
                                                 relatedBy: .equal,
                                                 toItem: signupButton,
                                                 attribute: .bottom,
                                                 multiplier: 1,
                                                 constant: 40))
        
        let verticalTextFieldsConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-50-[username]-15-[harbour]-15-[boat]-15-[mail]-15-[password]",
            options: .alignAllCenterX,
            metrics: nil,
            views: views)
        allConstraints += verticalTextFieldsConstraint
        
        allConstraints.append(NSLayoutConstraint(item: signupButton,
                                                 attribute: .top,
                                                 relatedBy: .equal,
                                                 toItem: passwordTextField,
                                                 attribute: .bottom,
                                                 multiplier: 1,
                                                 constant: 8))
        
        let alignButtonsConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[cancelButton]-[signupButton]-|",
            options: .alignAllCenterY,
            metrics: nil,
            views: views)
        allConstraints += alignButtonsConstraint
    }
    
    @objc func didTapSignup(sender: Any) {
       signup()
    }
    
    @objc func didTapCancel(sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func signup() {
        let email = mailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil {
                Auth.auth().signIn(withEmail: self.mailTextField.text!,
                                   password: self.passwordTextField.text!)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}
