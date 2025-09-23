//
//  ViewModel.swift
//  iOS-MVVM-Olga Mikhailova
//
//  Created by FoxxFire on 22.09.2025.
//

import Foundation

protocol AlbumsViewModelProtocol: AnyObject {
    var sections: [AlbumSection] { get }
    func loadData()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> CellItemProtocol?
    func didSelectItem(at indexPath: IndexPath)
    func didTapHeaderButton(in section: Int)
    func headerTitle(for section: Int) -> String?
    func headerButtonTitle(for section: Int) -> String?
    func layoutType(for section: Int) -> AlbumCompositionalLayout.LayoutType?
}

class AlbumsViewModel: AlbumsViewModelProtocol {
    
    // MARK: - Properties

    private let dataService: AlbumsDataServiceProtocol
    var sections: [AlbumSection] = []
    
    // MARK: - Init
    
    init(dataService: AlbumsDataServiceProtocol) {
        self.dataService = dataService
    }
    
    // MARK: - Public Methods
    
    func loadData() {
        sections = dataService.getAllSections()
    }
    
    //MARK: - helpers for DataSource
  
        func numberOfSections() -> Int {
            return sections.count
        }
    
        func numberOfItems(in section: Int) -> Int {
            guard section < sections.count else { return 0 }
            return sections[section].items.count
        }
    
        func item(at indexPath: IndexPath) -> CellItemProtocol? {
            guard indexPath.section < sections.count,
                  indexPath.item < sections[indexPath.section].items.count else {
                return nil
            }
            return sections[indexPath.section].items[indexPath.item]
        }
    
        func didSelectItem(at indexPath: IndexPath) {
            guard let item = item(at: indexPath) else { return }
            print("Selected item: \(item.itemId)")
        }
    
    func didTapHeaderButton(in section: Int) {
        guard let sectionType = dataService.getSectionType(at: section) else {
            return
        }
        
        switch sectionType {
        case .myAlbums: print("See All tapped for My Albums")
        case .sharedAlbums: print("See All tapped for Shared Albums")
        case .mediaTypes, .other: print("Button tapped for section: \(sectionType.rawValue)")
        }
    }
    
    //MARK: - Headers
    
    func headerTitle(for section: Int) -> String? {
        guard let section = dataService.getSection(at: section) else { return nil }
        return section.header.title
    }
    
    func headerButtonTitle(for section: Int) -> String? {
        guard let section = dataService.getSection(at: section) else { return nil }
        return section.header.buttonTitle
    }
    
    //MARK: - layoutType
    
    func layoutType(for section: Int) -> AlbumCompositionalLayout.LayoutType? {
        guard let sectionType = dataService.getSectionType(at: section) else {
            return nil
        }
        
        switch sectionType {
        case .myAlbums: return .columns
        case .sharedAlbums: return .plain
        case .mediaTypes, .other: return .tableStyle
        }
    }
    
}



