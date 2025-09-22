//
//  AlbumsHeaderView.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 19.09.2025.
//
import UIKit

final class AlbumsHeaderView: UICollectionReusableView {
    
    static let identifier = "AlbumsHeaderView"
    
    // MARK: - Properties
    
    private var buttonAction: (() -> Void)?
    
    //MARK: - UI Elements
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var seeAllButton = makeSeeAllButton()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            seeAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeAllButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    //MARK: - UIMethods
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.titleColor
        label.font = Constants.titleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeSeeAllButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(Constants.buttonColor, for: .normal)
        button.titleLabel?.font = Constants.buttonFont
        button.addAction(UIAction { [weak self] _ in
            self?.buttonAction?()
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // MARK: - Configuration
    
    func configure(title: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        titleLabel.text = title
        
        if let buttonTitle = buttonTitle {
            configureWithButton(title: buttonTitle, action: buttonAction)
        } else {
            configureWithoutButton()
        }
    }
    
    private func configureWithButton(title: String, action: (() -> Void)?) {
        if seeAllButton.superview == nil {
            addSubview(seeAllButton)
            setupButtonConstraints()
        }
        
        seeAllButton.setTitle(title, for: .normal)
        buttonAction = action
        seeAllButton.isHidden = false
    }
    
    private func configureWithoutButton() {
        seeAllButton.removeFromSuperview()
        seeAllButton.isHidden = true
        buttonAction = nil
    }
    
    //MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        seeAllButton.setTitle(nil, for: .normal)
        buttonAction = nil
        seeAllButton.removeFromSuperview()
    }
}

// MARK: - Constants

private extension AlbumsHeaderView {
    enum Constants {
        static let horizontalPadding: CGFloat = 16
        static let titleColor: UIColor = .black
        static let buttonColor: UIColor = .systemBlue
        static let titleFont: UIFont = .systemFont(ofSize: 22, weight: .bold)
        static let buttonFont: UIFont = .systemFont(ofSize: 16, weight: .medium)
        static let buttonHeight: CGFloat = 30
    }
}

