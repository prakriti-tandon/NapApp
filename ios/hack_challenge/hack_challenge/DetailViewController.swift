//
//  DetailViewController.swift
//  hack_challenge
//
//  Created by Angela YUAN on 2023/4/29.
//

import UIKit

class DetailViewController: UIViewController {
    
    let picImageView = UIImageView()
    let nameTextField = UILabel()
    let snatchButton = UIButton()
    
    weak var del: updateCell?
    var location: Location
    var section: Int
    var index: Int
    
    init(location: Location, section: Int, index: Int) {
        self.location = location
        self.section = section
        self.index = index
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
        
        if location.availability {
            snatchButton.setTitle("Snatch location", for: .normal)
            snatchButton.setTitleColor(.black, for: .normal)
            snatchButton.backgroundColor = .green
            snatchButton.tintColor = .green
            snatchButton.addTarget(self, action: #selector(snatch), for: .touchUpInside)
        }
        else {
            snatchButton.setTitle("Cancel Snatch", for: .normal)
            snatchButton.setTitleColor(.white, for: .normal)
            snatchButton.backgroundColor = .red
            snatchButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        }
        
        
        snatchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snatchButton)
        
        setupConstraints()
        
    }
    
    @objc func snatch() {
        snatchButton.setTitle("Cancel Snatch", for: .normal)
        snatchButton.setTitleColor(.white, for: .normal)
        snatchButton.backgroundColor = .red
        snatchButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        del?.updateAvailability(index : self.index, section: self.section, availability: false)
    }
    
    @objc func cancel() {
        snatchButton.setTitle("Snatch Location", for: .normal)
        snatchButton.setTitleColor(.black, for: .normal)
        snatchButton.backgroundColor = .green
        snatchButton.addTarget(self, action: #selector(snatch), for: .touchUpInside)
        del?.updateAvailability(index : self.index, section: self.section, availability: true)
    }
    
        
        func setupConstraints() {
            NSLayoutConstraint.activate([
                picImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                picImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                picImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
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

protocol updateCell: ViewController {
    func updateAvailability(index: Int, section: Int, availability: Bool)
}
