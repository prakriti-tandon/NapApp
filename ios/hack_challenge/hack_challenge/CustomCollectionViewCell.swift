//
//  CustomCollectionViewCell.swift
//  hack_challenge
//
//  Created by Angela YUAN on 2023/4/29.
//
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let labelView = UILabel()
    let availabilityLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        labelView.textColor = .purple
        labelView.clipsToBounds = true
        contentView.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        availabilityLabel.text = "Available"
        availabilityLabel.backgroundColor = .red
        availabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(availabilityLabel)

        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -60)
        ])
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            labelView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            availabilityLabel.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            availabilityLabel.leadingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: 20)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update(location: Location) {
        imageView.image = UIImage(named: "image1")
        labelView.text = location.building
        if (location.occupied) {
            availabilityLabel.text = "Reserved"
            availabilityLabel.textColor = .white
            availabilityLabel.backgroundColor = .red
        }
        else {
            availabilityLabel.text = "Available"
            availabilityLabel.textColor = .black
            availabilityLabel.backgroundColor = .green
        }
    }
}
