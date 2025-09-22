//
//  SharedAlbumsCell.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 19.09.2025.
//
import UIKit

final class SharedAlbumsCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SharedAlbumsCell"
    
    // MARK: - UI Elements
    private lazy var imageView = makeImageView()
    private lazy var descriptionLabel = makeDescriptionLabel()
    private lazy var subtitle = makeSubtitleLabel()
    private lazy var stackView = makeStackView()
    
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
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(subtitle)
    }
    
    private func setupLayout() {
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.stackTopOffset),
            stackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - UI Methods
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Constants.imageBackgroundColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constants.descriptionFont
        label.textColor = Constants.descriptionColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.descriptionFont
        label.textColor = Constants.descriptionColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    // MARK: - Configuration
    
    func configuration(model: SharedAlbum) {
        descriptionLabel.text = model.title
        subtitle.text = model.subtitle
        configureImageView(with: model.imageName)
    }
    
    private func configureImageView(with imageName: String) {
        if let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: Constants.placeholderSystemImageName)
        }
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        descriptionLabel.text = nil
    }
}

// MARK: - Constants
extension SharedAlbumsCell {
    enum Constants {
        static let imageCornerRadius: CGFloat = 8
        static let descriptionTopOffset: CGFloat = 8
        static let imageBackgroundColor: UIColor = .systemGray5
        static let descriptionColor: UIColor = .black
        static let stackSpacing: CGFloat = 2
        static let stackTopOffset: CGFloat = 8
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        static let placeholderSystemImageName = "photo.on.rectangle"
    }
}


