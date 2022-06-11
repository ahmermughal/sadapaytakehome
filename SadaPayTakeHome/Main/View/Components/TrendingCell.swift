//
//  TrendingCell.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import UIKit
import UIView_Shimmer

class TrendingCell: UITableViewCell, ShimmeringViewProtocol {

    static let reuseID = "TrendingCellID"
    private let profileImageViewSize : CGFloat = 60.0
    private let userNameLabel = UILabel()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let languageLabel = UILabel()
    private let starsCountLabel = UILabel()
    private let profileImageView = UIImageView()
    
    var shimmeringAnimatedItems: [UIView] {
        [
            userNameLabel,
            nameLabel,
            profileImageView
        ]
    }
    
    private var descriptionBottomConstraint : NSLayoutConstraint!
    private var descriptionHeightConstraint : NSLayoutConstraint!
    private var languageHeightConstraint : NSLayoutConstraint!
    private var starsHeightConstraint: NSLayoutConstraint!
    private var nameLabelBottomConstaint : NSLayoutConstraint!
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
        setImageWithStringOn(label: languageLabel, string: repo.language ?? "", image: UIImage(systemName: "circle.fill")!, color: .systemBlue)
        setImageWithStringOn(label: starsCountLabel, string: String(format: "%.0f", repo.stars), image: UIImage(systemName: "star.fill")!, color: .golden)
        
        profileImageView.downloadImage(fromURL: repo.owner.avatarUrl)
        
        if repo.isExpanded{
            expandCell()
        }else{
            shrinkCell()
        }
        
    }
    
    func expandCell(){
        nameLabelBottomConstaint.isActive = false
        languageHeightConstraint.constant = 30
        starsHeightConstraint.constant = 30
        descriptionHeightConstraint.isActive = false
        descriptionBottomConstraint.isActive = true
    }

    func shrinkCell(){
        languageHeightConstraint.constant = 0
        starsHeightConstraint.constant = 0
        descriptionHeightConstraint.isActive = true
        descriptionBottomConstraint.isActive = false
        nameLabelBottomConstaint.isActive = true

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
        userNameLabel.text = "abcabcabc"
        nameLabel.text = "asdakjdasadskj"
        
   
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
        
        descriptionBottomConstraint =             descriptionLabel.bottomAnchor.constraint(equalTo: languageLabel.topAnchor, constant: -8)
        
        descriptionHeightConstraint = descriptionLabel.heightAnchor.constraint(equalToConstant: 0)
        
        languageHeightConstraint =             languageLabel.heightAnchor.constraint(equalToConstant: 0)
        
        starsHeightConstraint =             starsCountLabel.heightAnchor.constraint(equalToConstant: 0)
        
        nameLabelBottomConstaint = nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32)
        
        NSLayoutConstraint.activate([
        
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewSize),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewSize),
            
            userNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabelBottomConstaint,
            
            languageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            languageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            languageHeightConstraint,
            
            starsCountLabel.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor, constant: 16),
            starsCountLabel.bottomAnchor.constraint(equalTo: languageLabel.bottomAnchor),
            starsHeightConstraint,
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            descriptionHeightConstraint
        
        ])
        
    }
    

}
