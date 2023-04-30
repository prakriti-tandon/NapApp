//
//  DetailViewController.swift
//  hack_challenge
//
//  Created by Angela YUAN on 2023/4/29.
//

import UIKit

class DetailViewController: UIViewController {
    
    let picImageView = UIImageView()
    let nameTextField = UITextField()
    let snatchButton = UIButton()
    
    
    
    let location: Location
    
    init(location: Location) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location Info"
        
        view.backgroundColor = .white
        
        picImageView.image = UIImage(named:location.imageName)
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picImageView)
        
        nameTextField.text = location.description
        nameTextField.font = .systemFont(ofSize: 20)
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 5
        nameTextField.clipsToBounds = true
        nameTextField.textAlignment = .center
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
    
        snatchButton.setTitle("snatch location", for: .normal)
        snatchButton.backgroundColor = .green
        snatchButton.tintColor = .green
        snatchButton.addTarget(self, action: #selector(snatch), for: .touchUpInside)
        snatchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snatchButton)
        
        setupConstraints()
        
    }
    
    @objc func snatch() {
        print("hi")
        
        
    }
    
        
        func setupConstraints() {
            NSLayoutConstraint.activate([
                picImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                picImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                picImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                picImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            ])
            
            NSLayoutConstraint.activate([
                nameTextField.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: 10),
                nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            ])
            
            NSLayoutConstraint.activate([
                snatchButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 90),
                snatchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                snatchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            ])
            
        }
        
       
        
    
}
