//
//  SharedAlbumsFirstCell.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 19.09.2025.
//
//
//  SharedAlbumsFirstCell.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 12.09.2025.
//

import UIKit

final class SharedAlbumsFirstCell: UICollectionViewCell {
    
    static let identifier = "SharedAlbumsFirstCell"
    
    // MARK: - Properties
    
    private var circles = [UIImageView]()
    
    // MARK: - UI Elements
    
    private lazy var circleContainer = makeCircleContainer()
    private lazy var descriptionLabel = makeDescriptionLabel()
    private lazy var subtitle = makeSubtitleLabel()
    private lazy var stackView = makeStackView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCircles()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR")
    }
    
    // MARK: - Setup
    
    private func createCircles() {
        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = Constants.circleSize / 2
            circles.append(imageView)
        }
    }
    
    private func setupHierarchy() {
        contentView.addSubview(circleContainer)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(subtitle)
        circles.forEach { circleContainer.addSubview($0) }
    }
    
    private func setupLayout() {
        setupCircleContainerConstraints()
        setupDescriptionLabelsConstraints()
        setupCirclesConstraints()
    }
    
    private func setupCircleContainerConstraints() {
        NSLayoutConstraint.activate([
            circleContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            circleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            circleContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            circleContainer.heightAnchor.constraint(equalTo: circleContainer.widthAnchor)
        ])
    }
    
    private func setupDescriptionLabelsConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: circleContainer.bottomAnchor, constant: Constants.stackTopOffset),
            stackView.leadingAnchor.constraint(equalTo: circleContainer.leadingAnchor)
        ])
    }
    
    private func setupCirclesConstraints() {
        // Центрируем всю группу кружков
        let groupView = UIView()
        circleContainer.addSubview(groupView)
        
        groupView.translatesAutoresizingMaskIntoConstraints = false
        
        // Центрируем группу
        NSLayoutConstraint.activate([
            groupView.centerXAnchor.constraint(equalTo: circleContainer.centerXAnchor),
            groupView.centerYAnchor.constraint(equalTo: circleContainer.centerYAnchor),
            groupView.widthAnchor.constraint(equalToConstant: Constants.circleSize * 2 + Constants.circleHorizontalSpacing),
            groupView.heightAnchor.constraint(equalToConstant: Constants.circleSize * 2 + Constants.circleVerticalSpacing)
        ])
        
        // Располагаем кружки в сетке 2x2
        for (index, circle) in circles.enumerated() {
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.removeFromSuperview()
            groupView.addSubview(circle)
            
            NSLayoutConstraint.activate([
                circle.widthAnchor.constraint(equalToConstant: Constants.circleSize),
                circle.heightAnchor.constraint(equalToConstant: Constants.circleSize)
            ])
            
            switch index {
            case 0: // top-leading
                NSLayoutConstraint.activate([
                    circle.topAnchor.constraint(equalTo: groupView.topAnchor),
                    circle.leadingAnchor.constraint(equalTo: groupView.leadingAnchor)
                ])
            case 1: // top-trailing
                NSLayoutConstraint.activate([
                    circle.topAnchor.constraint(equalTo: groupView.topAnchor),
                    circle.trailingAnchor.constraint(equalTo: groupView.trailingAnchor)
                ])
            case 2: // bottom-leading
                NSLayoutConstraint.activate([
                    circle.bottomAnchor.constraint(equalTo: groupView.bottomAnchor),
                    circle.leadingAnchor.constraint(equalTo: groupView.leadingAnchor)
                ])
            case 3: // bottom-trailing
                NSLayoutConstraint.activate([
                    circle.bottomAnchor.constraint(equalTo: groupView.bottomAnchor),
                    circle.trailingAnchor.constraint(equalTo: groupView.trailingAnchor)
                ])
            default:
                break
            }
        }
    }
    
    // MARK: - UI Methods
    
    private func makeCircleContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = Constants.containerCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constants.descriptionFont
        label.textColor = Constants.descriptionColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeCircleImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.circleSize / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    func configuration(model: FirstSharedAlbum) {
        descriptionLabel.text = model.title
        subtitle.text = model.subtitle
        configureCircles(with: model.imageNames)
    }
    
    private func configureCircles(with imageName: [String]) {
        for (index, circle) in circles.enumerated() {
            if index < imageName.count {
                if let image = UIImage(named: imageName[index]) {
                    circle.image = image
                    circle.backgroundColor = .clear
                } else {
                    circle.image = UIImage(
                        systemName: Constants.placeholderSystemImageName
                    )
                    circle.backgroundColor = .systemGray5
                }
            }
        }
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCircles()
        descriptionLabel.text = nil
    }
    
    private func resetCircles() {
        circles.forEach { circle in
            circle.image = nil
            circle.backgroundColor = .systemGray5
        }
    }
}

// MARK: - Constants

extension SharedAlbumsFirstCell {
    enum Constants {
        static let circleSize: CGFloat = 80
        static let circleHorizontalSpacing: CGFloat = 16
        static let circleVerticalSpacing: CGFloat = 4
        static let containerCornerRadius: CGFloat = 8
        static let descriptionTopOffset: CGFloat = 7
        static let stackTopOffset: CGFloat = 8
        static let stackSpacing: CGFloat = 2
        static let descriptionColor: UIColor = .black
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        static let placeholderSystemImageName = "person.circle.fill"
    }
}


