//
//  AlbumsPresenter.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 18.09.2025.
//

import Foundation

/*
 MVP (Model-View-Presenter)
 Роли:
 
 Model: Данные и бизнес-логика. Не уведомляет View напрямую.
 
 View: Чисто пассивный интерфейс. Только отображает то, что ей передали, и передает пользовательский ввод Presenter'у. В контексте Android это часто является Activity или Fragment, реализующий контракт (интерфейс).
 
 Presenter: "Мозг" представления. Получает события от View, запрашивает данные из Model, обрабатывает их и явно обновляет View, передавая ей готовые для отображения данные.
 
 Взаимодействие:
 
 Пользователь взаимодействует с View (вводит текст в поле).
 
 View сразу же вызывает соответствующий метод Presenterа ("пользователь ввел текст").
 
 Presenter обрабатывает логику (например, валидацию), запрашивает или обновляет Model.
 
 Presenter получает результат от Model, подготавливает данные для отображения (например, преобразует raw-данные в строку).
 
 Presenter вызывает метод интерфейса View (например, showSuccessMessage() или setDataToScreen()) и передает готовые данные.
 
 View получает команду и просто отображает переданные данные.
 
 Ключевой момент: Связи между View и Model нет. Весь поток данных контролируется Presenterом.
 */

protocol AlbumsViewProtocol: AnyObject {
    func reloadData()
}

protocol AlbumsPresenterProtocol: AnyObject {
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> CellItemProtocol?
    func didSelectItem(at indexPath: IndexPath)
    func headerTitle(for section: Int) -> String?
    func headerButtonTitle(for section: Int) -> String?
    func didTapHeaderButton(in section: Int)
    func layoutType(for section: Int) -> AlbumCompositionalLayout.LayoutType?
}

final class AlbumsPresenter: AlbumsPresenterProtocol {
    
    // MARK: - Properties
    weak var view: AlbumsViewProtocol?
    private let dataService: AlbumsDataServiceProtocol
    
    // MARK: - Init
    init(dataService: AlbumsDataServiceProtocol) {
        self.dataService = dataService
    }
    
    // Бизнес-логика из контроллера
    func numberOfSections() -> Int {
        return dataService.getAllSections().count
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard let section = dataService.getSection(at: section) else { return 0 }
        return section.items.count
    }
    
    func item(at indexPath: IndexPath) -> CellItemProtocol? {
        guard let section = dataService.getSection(at: indexPath.section),
              indexPath.item < section.items.count else {
            return nil
        }
        return section.items[indexPath.item]
    }
    
    func headerTitle(for section: Int) -> String? {
        guard let section = dataService.getSection(at: section) else { return nil }
        return section.header.title
    }
    
    func headerButtonTitle(for section: Int) -> String? {
        guard let section = dataService.getSection(at: section) else { return nil }
        return section.header.buttonTitle
    }
    
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
}

