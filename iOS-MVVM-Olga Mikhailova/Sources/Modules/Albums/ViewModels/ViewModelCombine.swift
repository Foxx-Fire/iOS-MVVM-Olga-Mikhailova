//
//  ViewModelCombine.swift
//  iOS-MVVM-Olga Mikhailova
//
//  Created by FoxxFire on 26.09.2025.
//

import Combine
import Foundation

protocol AlbumsViewModelProtocolCombine: ObservableObject {
    var sections: [AlbumSection] { get }
    var isLoading: Bool { get }
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

final class AlbumsViewModelCombine: AlbumsViewModelProtocolCombine {
    
    // MARK: - Properties
    
    private let dataService: AlbumsDataServiceProtocol
    @Published var sections: [AlbumSection] = []
    @Published var isLoading: Bool = false
    
    // MARK: - Init
    
    init(dataService: AlbumsDataServiceProtocol) {
        self.dataService = dataService
    }
    
    // MARK: - Public Methods
    
    func loadData() {
        isLoading = true // ← Начало загрузки
        
        // Имитируем асинхронную загрузку
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let sectionsData = self.dataService.getAllSections()
            self.sections = sectionsData
            self.isLoading = false // ← Конец загрузки
        }
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
        guard section < sections.count else { return }
        
        switch sections[section].type {
        case .myAlbums: print("See All tapped for My Albums")
        case .sharedAlbums: print("See All tapped for Shared Albums")
        case .mediaTypes, .other: print("Button tapped for section: \(sections[section].type.rawValue)")
        }
    }
    
    //MARK: - Headers
    
    func headerTitle(for section: Int) -> String? {
        guard section < sections.count else { return nil }
        return sections[section].header.title
    }
    
    func headerButtonTitle(for section: Int) -> String? {
        guard section < sections.count else { return nil }
        return sections[section].header.buttonTitle
    }
    
    //MARK: - layoutType
    
    func layoutType(for section: Int) -> AlbumCompositionalLayout.LayoutType? {
        guard section < sections.count else { return nil }
        
        switch sections[section].type {
        case .myAlbums: return .columns
        case .sharedAlbums: return .plain
        case .mediaTypes, .other: return .tableStyle
        }
    }
}



