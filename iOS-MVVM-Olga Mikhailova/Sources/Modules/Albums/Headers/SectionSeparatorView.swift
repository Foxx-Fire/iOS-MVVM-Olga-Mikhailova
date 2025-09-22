//
//  SectionSeparatorView.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 19.09.2025.
//
import UIKit

final class SectionSeparatorView: UICollectionReusableView {
    
    static let identifier = "SectionSeparatorView"
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(separatorView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}


