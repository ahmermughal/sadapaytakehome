//
//  TrendingCell.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import UIKit

class TrendingCell: UITableViewCell {

    static let reuseID = "TrendingCellID"
    private let profileImageViewSize : CGFloat = 60.0
    private let userNameLabel = UILabel()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let languageLabel = UILabel()
    private let starsCountLabel = UILabel()
    private let profileImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(repo: Repo){
        userNameLabel.text = repo.owner.login
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description
        setImageWithStringOn(label: languageLabel, string: repo.language, image: UIImage(systemName: "circle.fill")!, color: .systemBlue)
        setImageWithStringOn(label: starsCountLabel, string: repo.stars, image: UIImage(systemName: "star.fill")!, color: .systemBlue)
    }
    
    private func configure(){
        descriptionLabel.numberOfLines = 0
        profileImageView.layer.cornerRadius = profileImageViewSize/2
        profileImageView.clipsToBounds = true
        
        userNameLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        languageLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        starsCountLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        userNameLabel.adjustsFontForContentSizeCategory = true
        languageLabel.adjustsFontForContentSizeCategory = true
        starsCountLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.adjustsFontForContentSizeCategory = true
   
    }
    
    private func setImageWithStringOn(label : UILabel, string: String, image: UIImage, color: UIColor){
        let attrString = NSMutableAttributedString(string: "")

        let textAttachment = NSTextAttachment()
        textAttachment.image = image.withTintColor(color, renderingMode: .alwaysTemplate)
        
        let imageStr = NSAttributedString(attachment: textAttachment)

        attrString.append(imageStr)
        attrString.append(NSAttributedString(string: " \(string)"))

        label.attributedText = attrString
    }
    
    private func layout(){
        let views = [profileImageView, userNameLabel, nameLabel, descriptionLabel, languageLabel, starsCountLabel]
        
        for view in views{
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
        
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewSize),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewSize),
            
            
            userNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            userNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            languageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            languageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            languageLabel.heightAnchor.constraint(equalToConstant: 20),
            
            starsCountLabel.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor, constant: 16),
            starsCountLabel.bottomAnchor.constraint(equalTo: languageLabel.bottomAnchor),
            starsCountLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: languageLabel.topAnchor, constant: -8),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        
        ])
        
    }
    

}
