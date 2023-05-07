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
    let brightness = UILabel()
    let dimness = UILabel()
    let noiseLevel = UILabel()
    let quiet = UILabel()
    let availabilityTextField = UILabel()
    let snatchButton = UIButton()
    let locationTextField = UILabel()
    let roomTextField = UILabel()
    
    weak var del: updateCell?
    var location: Location
    var section: Int
    var index: Int
    
    let infoPaddingTop = CGFloat(integerLiteral: 40)
    let infoPaddingLead = CGFloat(integerLiteral: 10)
    let infoPaddingBetween = CGFloat(integerLiteral: 40)
    
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
        
        picImageView.image = UIImage(named: location.building)
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picImageView)
        
        nameTextField.text = location.building
        nameTextField.font = UIFont.boldSystemFont(ofSize: 30)
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 5
        nameTextField.clipsToBounds = true
        nameTextField.textAlignment = .center
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        
        //add
        
        if !location.dark {
            dimness.text = "Light"
            dimness.font = UIFont.boldSystemFont(ofSize: 20)
            dimness.backgroundColor = .systemGray5
            dimness.layer.cornerRadius = 5
            dimness.clipsToBounds = true
            dimness.textAlignment = .center
            dimness.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(dimness)
        }
        
        else {
            dimness.text = "Dark"
            dimness.font = UIFont.boldSystemFont(ofSize: 20)
            dimness.backgroundColor = .systemGray5
            dimness.layer.cornerRadius = 5
            dimness.clipsToBounds = true
            dimness.textAlignment = .center
            dimness.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(dimness)
        }
        
        
        //edit
        if !location.quiet {
            quiet.text = "Loud"
            quiet.font = UIFont.boldSystemFont(ofSize: 20)
            quiet.backgroundColor = .systemGray5
            
            quiet.layer.cornerRadius = 5
            quiet.clipsToBounds = true
            quiet.textAlignment = .center
            quiet.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(quiet)
        }
        
        else {
            quiet.text = "Quiet"
            quiet.font = UIFont.boldSystemFont(ofSize: 20)
            quiet.backgroundColor = .systemGray5
            quiet.layer.cornerRadius = 5
            quiet.clipsToBounds = true
            quiet.textAlignment = .center
            quiet.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(quiet)
        }
            
            
            
        if !location.occupied {
            availabilityTextField.text = "Available"
            availabilityTextField.textColor = UIColor(named: "darkgreen")
            
            snatchButton.setTitle("Reserve", for: .normal)
            snatchButton.setTitleColor(.black, for: .normal)
            snatchButton.backgroundColor = UIColor(named: "green")
            snatchButton.tintColor = .green
            snatchButton.addTarget(self, action: #selector(snatch), for: .touchUpInside)
        }
        else {
            availabilityTextField.text = "Unavailable"
            availabilityTextField.textColor = .red
            
            snatchButton.setTitle("Cancel Snatch", for: .normal)
            snatchButton.setTitleColor(.white, for: .normal)
            snatchButton.backgroundColor = .red
            snatchButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        }
        
        availabilityTextField.font = UIFont.systemFont(ofSize: 20)
        availabilityTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(availabilityTextField)
        snatchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snatchButton)
        
        locationTextField.text = "Location: "
        locationTextField.textColor = UIColor.black
        locationTextField.font = UIFont.systemFont(ofSize: 20)
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationTextField)
        
        brightness.text = "Brightness: "
        brightness.textColor = UIColor.black
        brightness.font = UIFont.systemFont(ofSize: 20)
        brightness.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(brightness)
        
        noiseLevel.text = "Noise Level: "
        noiseLevel.textColor = UIColor.black
        noiseLevel.font = UIFont.systemFont(ofSize: 20)
        noiseLevel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noiseLevel)
        
        roomTextField.text = location.room
        roomTextField.textColor = UIColor.black
        roomTextField.font = UIFont.boldSystemFont(ofSize: 20)
        roomTextField.translatesAutoresizingMaskIntoConstraints = false
        roomTextField.backgroundColor = .systemGray5
        view.addSubview(roomTextField)
//        roomTextField.layer.borderWidth = 1
//        roomTextField.layer.borderColor = UIColor.black.cgColor
//        roomTextField.backgroundColor = UIColor(named: "lightgray")
        
        setupConstraints()
        
    }
    
    @objc func snatch() {
        availabilityTextField.text = "Unavailable"
        availabilityTextField.textColor = .red
        
        snatchButton.setTitle("Cancel Snatch", for: .normal)
        snatchButton.setTitleColor(.white, for: .normal)
        snatchButton.backgroundColor = .red
        snatchButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        del?.updateAvailability(index : self.index, section: self.section, availability: false)
    }
    
    @objc func cancel() {
        availabilityTextField.text = "Available"
        availabilityTextField.textColor = UIColor(named: "darkgreen")
        
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
                availabilityTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
                availabilityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ])
            
            NSLayoutConstraint.activate([
                locationTextField.topAnchor.constraint(equalTo: availabilityTextField.bottomAnchor, constant: infoPaddingTop),
                locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: infoPaddingLead)
            ])
            
            NSLayoutConstraint.activate([
                brightness.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: infoPaddingTop),
                brightness.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: infoPaddingLead)
            ])
            
            NSLayoutConstraint.activate([
                noiseLevel.topAnchor.constraint(equalTo: brightness.bottomAnchor, constant: infoPaddingTop),
                noiseLevel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: infoPaddingLead)
            ])
            
            
            NSLayoutConstraint.activate([
                roomTextField.centerYAnchor.constraint(equalTo: locationTextField.centerYAnchor),
                roomTextField.leadingAnchor.constraint(equalTo: locationTextField.trailingAnchor, constant: infoPaddingBetween)
            ])
            
            NSLayoutConstraint.activate([
                dimness.topAnchor.constraint(equalTo: roomTextField.bottomAnchor, constant: infoPaddingTop),
                dimness.leadingAnchor.constraint(equalTo: locationTextField.trailingAnchor, constant: infoPaddingBetween)
            ])
            
            NSLayoutConstraint.activate([
                quiet.topAnchor.constraint(equalTo: dimness.bottomAnchor, constant: infoPaddingTop),
                quiet.leadingAnchor.constraint(equalTo: locationTextField.trailingAnchor, constant: infoPaddingBetween)
            ])
            
            NSLayoutConstraint.activate([
                snatchButton.topAnchor.constraint(equalTo: dimness.bottomAnchor, constant: 150),
                snatchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                snatchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            ])
            
        }
}

protocol updateCell: ViewController {
    func updateAvailability(index: Int, section: Int, availability: Bool)
}
