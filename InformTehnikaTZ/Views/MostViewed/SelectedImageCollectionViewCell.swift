//
//  SelectedImageCollectionViewCell.swift
//  InformTehnikaTZ
//
//  Created by Александр Гужавин on 07.06.2023.
//

import UIKit

class SelectedImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SelectedImageCollectionViewCell"
    
    private let selectedImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setImage(imageData: Data?) {
        selectedImageView.image = imageData == nil ? UIImage(systemName: "person.circle") : UIImage(data: imageData!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(selectedImageView)
        selectedImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        selectedImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        selectedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        selectedImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        selectedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        selectedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
