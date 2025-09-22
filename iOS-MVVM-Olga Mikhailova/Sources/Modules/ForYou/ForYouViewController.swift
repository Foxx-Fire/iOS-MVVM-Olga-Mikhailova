//
//  ForYouViewController.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 18.09.2025.
//
import UIKit

final class ForYouViewController: BaseViewController {
    
    private let forYouView = ForYouView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        view = forYouView
    }
    
    func setupNavigation() {
        configureNavigation(title: Constants.Navigation.title)
    }
}

// MARK: - Constants

extension ForYouViewController {
    enum Constants {
        enum Navigation {
            static let title = "For You"
        }
    }
}

