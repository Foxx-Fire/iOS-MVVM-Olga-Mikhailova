//
//  MediaTypesCell.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 19.09.2025.
//

import UIKit

final class MediaTypesCell: UICollectionViewCell {
    
    static let identifier = "MediaTypesCell"
    
    // MARK: - UI Elements
    
    private lazy var iconImageView = makeIconImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var countLabel = makeCountLabel()
    private lazy var chevronImageView = makeChevronImageView()
    private lazy var separatorView = makeSeparatorView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.textSpacing),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: Constants.chevronSize),
            chevronImageView.heightAnchor.constraint(equalToConstant: Constants.chevronSize),
            
            
            countLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -Constants.textSpacing),
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorHeight)
        ])
    }
    
    //MARK: - UIMethods
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.iconTintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.titleFont
        label.textColor = Constants.titleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeCountLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.countFont
        label.textColor = Constants.countColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeChevronImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.chevronTintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func makeSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = Constants.separatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    // MARK: - Configuration
    
    func configuration(model: MediaAndOther) {
        iconImageView.image = UIImage(systemName: model.imageName)
        titleLabel.text = model.title
        countLabel.text = "\(model.count)"
        chevronImageView.image = UIImage(systemName: model.chevronName)
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
        countLabel.text = nil
    }
}

// MARK: - Constants

private extension MediaTypesCell {
    enum Constants {
        static let horizontalPadding: CGFloat = 1
        static let textSpacing: CGFloat = 12
        static let iconSize: CGFloat = 28
        static let chevronSize: CGFloat = 12
        static let separatorHeight: CGFloat = 0.5
        static let iconTintColor: UIColor = .systemBlue
        static let titleColor: UIColor = .systemBlue
        static let countColor: UIColor = .systemGray
        static let chevronTintColor: UIColor = .systemGray
        static let separatorColor: UIColor = .systemGray5
        static let titleFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
        static let countFont: UIFont = .systemFont(ofSize: 16)
    }
}

