
  ViewModel.swift
  iOS-MVVM-Olga Mikhailova

  Created by FoxxFire on 22.09.2025.


import Foundation

protocol AlbumsViewModelProtocol: AnyObject {
    var sections: Observable<[AlbumSection]> { get }
    var isLoading: Observable<Bool> { get }
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

final class AlbumsViewModel: AlbumsViewModelProtocol {
    
    // MARK: - Properties

    private let dataService: AlbumsDataServiceProtocol
    var sections = Observable<[AlbumSection]>([])
    var isLoading = Observable<Bool>(false)
    
    // MARK: - Init
    
    init(dataService: AlbumsDataServiceProtocol) {
        self.dataService = dataService
    }
    
    // MARK: - Public Methods
    
    func loadData() {
        isLoading.value = true // ← Начало загрузки
        
        // Имитируем асинхронную загрузку
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let sectionsData = self.dataService.getAllSections()
            self.sections.value = sectionsData
            self.isLoading.value = false // ← Конец загрузки
        }
    }
    
    //MARK: - helpers for DataSource
  
        func numberOfSections() -> Int {
            return sections.value.count
        }
    
        func numberOfItems(in section: Int) -> Int {
            guard section < sections.value.count else { return 0 }
            return sections.value[section].items.count
        }
    
        func item(at indexPath: IndexPath) -> CellItemProtocol? {
            guard indexPath.section < sections.value.count,
                  indexPath.item < sections.value[indexPath.section].items.count else {
                return nil
            }
            return sections.value[indexPath.section].items[indexPath.item]
        }
    
        func didSelectItem(at indexPath: IndexPath) {
            guard let item = item(at: indexPath) else { return }
            print("Selected item: \(item.itemId)")
        }
    
    func didTapHeaderButton(in section: Int) {
        guard section < sections.value.count else { return }
        
        switch sections.value[section].type {
        case .myAlbums: print("See All tapped for My Albums")
        case .sharedAlbums: print("See All tapped for Shared Albums")
        case .mediaTypes, .other: print("Button tapped for section: \(sections.value[section].type.rawValue)")
        }
    }
    
    //MARK: - Headers
    
    func headerTitle(for section: Int) -> String? {
        guard section < sections.value.count else { return nil }
        return sections.value[section].header.title
    }
    
    func headerButtonTitle(for section: Int) -> String? {
        guard section < sections.value.count else { return nil }
        return sections.value[section].header.buttonTitle
    }
    
    //MARK: - layoutType
    
    func layoutType(for section: Int) -> AlbumCompositionalLayout.LayoutType? {
        guard section < sections.value.count else { return nil }
        
        switch sections.value[section].type {
        case .myAlbums: return .columns
        case .sharedAlbums: return .plain
        case .mediaTypes, .other: return .tableStyle
        }
    }
    
}



