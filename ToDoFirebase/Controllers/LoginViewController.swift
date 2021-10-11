//
//  LoginViewController.swift
//  ToDoFirebase
//
//  Created by Oleg Kanatov on 6.10.21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    private let contentStack = UIStackView()
    private let headUserStack = UIStackView()
    private let headLabel = UILabel()
    private let warningLabel = UILabel()
    private let emailPasswordStack = UIStackView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginRegisterStack = UIStackView()
    private let loginButton = UIButton(type: .system)
    private let registerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
        
        examination()
        viewSetup()
        keyboardSetup()
        contentStackSetup()
        headStackSetup()
        headLabelSetup()
        userLabelSetup()
        emailPasswordStackSetup()
        emailTextFieldSetup()
        passwordTextFieldSetup()
        loginRegisterStackSetup()
        loginButtonSetup()
        registerButtonSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func loadView() {
        super.loadView()
        view = UIScrollView()
    }
    
    
    //-------------------------------------------------
    // MARK: - Content
    //-------------------------------------------------
    
    private func viewSetup() {
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    
    private func contentStackSetup() {
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.distribution = .fill
        contentStack.spacing = 50
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(headUserStack)
        contentStack.addArrangedSubview(emailPasswordStack)
        contentStack.addArrangedSubview(loginRegisterStack)
        NSLayoutConstraint.activate([
            contentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func headStackSetup() {
        headUserStack.axis = .vertical
        headUserStack.alignment = .center
        headUserStack.distribution = .fill
        headUserStack.spacing = 40
        headUserStack.translatesAutoresizingMaskIntoConstraints = false
        headUserStack.addArrangedSubview(headLabel)
        headUserStack.addArrangedSubview(warningLabel)
    }
    
    private func headLabelSetup() {
        headLabel.text = "ToDoFIRE"
        headLabel.font = UIFont(name: "TamilSangamMN", size: 40)
        headLabel.tintColor = .white
        headLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func userLabelSetup() {
        warningLabel.text = "Error"
        warningLabel.alpha = 0
        warningLabel.font = UIFont(name: "TamilSangamMN", size: 18)
        warningLabel.textColor = .red
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func emailPasswordStackSetup() {
        emailPasswordStack.axis = .vertical
        emailPasswordStack.alignment = .center
        emailPasswordStack.spacing = 10
        emailPasswordStack.addArrangedSubview(emailTextField)
        emailPasswordStack.addArrangedSubview(passwordTextField)
        NSLayoutConstraint.activate([
            emailPasswordStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            emailPasswordStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor)
        ])
    }
    
    private func emailTextFieldSetup() {
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont(name: "TamilSangamMN", size: 17)
        emailTextField.backgroundColor = .white
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: emailPasswordStack.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailPasswordStack.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func passwordTextFieldSetup() {
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont(name: "TamilSangamMN", size: 17)
        passwordTextField.backgroundColor = .white
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: emailPasswordStack.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailPasswordStack.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func loginRegisterStackSetup() {
        loginRegisterStack.axis = .vertical
        loginRegisterStack.alignment = .center
        loginRegisterStack.spacing = 20
        loginRegisterStack.addArrangedSubview(loginButton)
        loginRegisterStack.addArrangedSubview(registerButton)
        NSLayoutConstraint.activate([
            loginRegisterStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 40),
            loginRegisterStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -40)
        ])
    }
    
    private func loginButtonSetup() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.tintColor = .white
        loginButton.titleLabel?.font = UIFont(name: "TamilSangamMN", size: 25)
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.leadingAnchor.constraint(equalTo: loginRegisterStack.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginRegisterStack.trailingAnchor),
        ])
    }
    
    private func registerButtonSetup() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.tintColor = .white
        registerButton.titleLabel?.font = UIFont(name: "TamilSangamMN", size: 17)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.heightAnchor.constraint(equalToConstant: 45),
            registerButton.leadingAnchor.constraint(equalTo: loginRegisterStack.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: loginRegisterStack.trailingAnchor),
        ])
    }
    
    
    //-------------------------------------------------
    // MARK: - Authentication
    //-------------------------------------------------
    
    func displayWarningLabel(withText text: String) {
        warningLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warningLabel.alpha = 1
        }) { [weak self] complete in
            self?.warningLabel.alpha = 0
        }
    }
    
    @objc func loginTapped (_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            
            if user != nil {
                self?.viewSetup()
                return
            }
            
            self?.displayWarningLabel(withText: "No such user")
        })
        
    }
    
    @objc func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
            
            guard error == nil, user != nil else {
                print(error!.localizedDescription)
                return
            }
            let userRef = self?.ref.child((user?.user.uid)!)
            userRef?.setValue(["email": user?.user.email])
            
        })
    }
    
    //-------------------------------------------------
    // MARK: - Authentication check
    //-------------------------------------------------
    
    
    private func examination() {
        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            if user != nil {
                self?.nextView()
            }
        })
    }
    
    
    //-------------------------------------------------
    // MARK: - Transition
    //-------------------------------------------------
    
    private func nextView() {
        let taskVC = TaskViewController()
        let navigationViewController = UINavigationController(rootViewController: taskVC)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.show(navigationViewController, sender: self)
    }
    
    //-------------------------------------------------
    // MARK: - Keyboard
    //-------------------------------------------------
    
    private func keyboardSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc private func kbDidHide() {
        (view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
}

