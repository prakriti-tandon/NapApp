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

        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            
            
        ])
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            labelView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
   
        
            
            
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update(location: Location) {
        imageView.image = UIImage(named: location.imageName)
        labelView.text = location.description
        
    }
}
