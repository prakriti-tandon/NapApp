//
//  NewUserViewController.swift
//  hack_challenge
//
//  Created by David Vizueth on 5/7/23.
//

import UIKit

class NewUserViewController: UIViewController {


    let login = UITextField()
    let email = UITextField()
    let name = UITextField()
    let password = UITextField()
    let icon = UIImageView()
    let newAccount = UIButton()
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "blue")
        super.viewDidLoad()
        
        login.translatesAutoresizingMaskIntoConstraints = false
        login.text = "NapApp"
        login.font = .boldSystemFont(ofSize: 50)
        login.textColor = .black
        login.clipsToBounds = true
        login.textAlignment = .center
        view.addSubview(login)
        
        email.translatesAutoresizingMaskIntoConstraints = false
        email.text = "Email"
        email.font = .systemFont(ofSize: 20)
        email.borderStyle = .roundedRect
        email.clipsToBounds = true
        email.textAlignment = .center
        view.addSubview(email)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "username"
        name.font = .systemFont(ofSize: 20)
        name.borderStyle = .roundedRect
        name.clipsToBounds = true
        name.textAlignment = .center
        view.addSubview(name)
      
    
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
        
        newAccount.setTitle("Create", for: .normal)
        newAccount.setTitleColor(.systemBlue, for: .normal)
        newAccount.addTarget(self, action: #selector(createAction), for: .touchUpInside)
        newAccount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newAccount)
        
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
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 50)

        ])
        
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 30),

        ])
        
        NSLayoutConstraint.activate([
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 30)

        ])
        
        NSLayoutConstraint.activate([
            newAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newAccount.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 30)
        ])

    }
    
    
    @objc func createAction() {
        
        if let email = email.text {
            if let name = name.text {
                if let password = password.text{
                    NetworkManager.shared.registerUser(email: email, password: password, name: name) {_ in
                        
                    }
                }
                else { error() }
            }
            else { error() }
        }
        else { error() }
        
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func error() {
        print("Error Occurs Here")
    }
    
}
