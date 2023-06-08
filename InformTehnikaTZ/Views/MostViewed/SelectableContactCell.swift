//
//  SelectableContactCell.swift
//  InformTehnikaTZ
//
//  Created by Александр Гужавин on 07.06.2023.
//

import UIKit

class SelectableContactCell: UITableViewCell {
    
    static let identifier = "SelectableContactCell"
    
    private var selectedCell: Bool = false

    private let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contactFullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle")
        return imageView
    }()

    func setContact(contact: Contact) {
        contactImageView.image = contact.image == nil ? UIImage(systemName: "person.circle") : UIImage(data: contact.image!)
        contactFullNameLabel.text = contact.fullName
        contactPhoneNumberLabel.text = contact.phone
        
        selectedImageView.image = UIImage(systemName: "circle")
        contentView.backgroundColor = .clear
        selectedCell = false
    }
    
    func selectCell() -> Bool {
        
        if selectedCell {
            selectedImageView.image = UIImage(systemName: "circle")
            contentView.backgroundColor = .clear
            selectedCell = false
        } else {
            selectedImageView.image = UIImage(systemName: "checkmark.circle")
            contentView.backgroundColor = .systemGray6
            selectedCell = true
        }
        
        return selectedCell
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(contactImageView)
        contentView.addSubview(selectedImageView)
        contentView.addSubview(contactFullNameLabel)
        contentView.addSubview(contactPhoneNumberLabel)
        
        NSLayoutConstraint.activate([
            selectedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            selectedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            selectedImageView.widthAnchor.constraint(equalToConstant: 25),
            selectedImageView.heightAnchor.constraint(equalToConstant: 25),
            
            contactImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contactImageView.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: 8),
            contactImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contactImageView.widthAnchor.constraint(equalToConstant: 50),
            contactImageView.heightAnchor.constraint(equalToConstant: 50),
            
            
            contactFullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contactFullNameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 8),
            contactFullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            contactPhoneNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contactPhoneNumberLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 8) ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
