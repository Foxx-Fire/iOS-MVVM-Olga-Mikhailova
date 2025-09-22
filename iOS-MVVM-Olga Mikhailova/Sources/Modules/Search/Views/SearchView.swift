//
//  SearchView.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 18.09.2025.
//

import UIKit

final class SearchView: UIView {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setupView() {
        backgroundColor = Constants.backgroundColor
    }
}

// MARK: - Constants

extension SearchView {
    enum Constants {
        static let backgroundColor: UIColor = .yellow
    }
}
