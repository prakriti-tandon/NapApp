//
//  LoginViewController.swift
//  hack_challenge
//
//  Created by Angela YUAN on 2023/5/6.
//

import UIKit

class LoginViewController: UIViewController {

    let login = UITextField()
    let userName = UITextField()
    let password = UITextField()
    let button = UIButton()
    let icon = UIImageView()
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "purple")
        super.viewDidLoad()
        
        login.translatesAutoresizingMaskIntoConstraints = false
        login.text = "LOGIN PAGE"
        login.font = .systemFont(ofSize: 50)
        login.backgroundColor = UIColor(named: "purple")
        login.textColor = .white
        login.clipsToBounds = true
        login.textAlignment = .center
        view.addSubview(login)
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "username"
        userName.font = .systemFont(ofSize: 20)
        userName.borderStyle = .roundedRect
        userName.clipsToBounds = true
        userName.textAlignment = .center
        view.addSubview(userName)
      
    
        password.translatesAutoresizingMaskIntoConstraints = false
        password.clipsToBounds = true
        password.textAlignment = .center
        password.text = "password"
        password.font = .systemFont(ofSize: 20)
        password.borderStyle = .roundedRect
        view.addSubview(password)
        
        
        icon.image = UIImage(named:"sheep")
        icon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(icon)
        
        
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
       
        
        NSLayoutConstraint.activate([
            login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            login.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),

        ])
        
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            icon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            icon.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 60),
            icon.bottomAnchor.constraint(equalTo: login.bottomAnchor, constant: 150),
            icon.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
        
        NSLayoutConstraint.activate([
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 100),

        ])
        
        NSLayoutConstraint.activate([
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 30)

        ])
        
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 30)

        ])

    }
    
    
    @objc func buttonAction() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
