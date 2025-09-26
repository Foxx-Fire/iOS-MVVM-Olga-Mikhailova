//
//  Untitled.swift
//  iOS-MVVM-Olga Mikhailova
//
//  Created by FoxxFire on 26.09.2025.
//
import Combine
import UIKit

final class AlbumsViewControllerWithCombine: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: AlbumsViewModelCombine
    // для хранения подписок Combine
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var albumsView: AlbumsView = {
        let view = AlbumsView { [weak self] sectionIndex in
            self?.viewModel.layoutType(for: sectionIndex)
        }
        view.setupDataSource(dataSource: self)
        view.setupDelegate(delegate: self)
        return view
    }()
    
    //MARK: - Init
    init(viewModel: AlbumsViewModelCombine) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = albumsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupBindings()
        loadData()
    }
    
    //MARK: - private methods
    
    private func setupBindings() {
        // Подписываемся на изменения sections через Combine
        viewModel.$sections // ← Знак $ значит "дай мне Publisher этого свойства"
            .receive(on: DispatchQueue.main) //  Гарантируем главный поток
            .sink { [weak self] sections in // Подписываемся на изменения
                // Этот код выполнится КАЖДЫЙ РАЗ когда sections изменится
                print("Данные обновились! Секций: \(sections.count)")
                self?.albumsView.reloadData()
            }
            .store(in: &cancellables) //  Сохраняем подписку
        
        //  Подписываемся на изменения isLoading
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                print("Состояние загрузки: \(isLoading ? "началась" : "закончилась")")
                isLoading ? self?.showLoading() : self?.hideLoading()
            }
            .store(in: &cancellables)
    }
    
    private func showLoading() {
        // Показываем индикатор загрузки
        print("Loading started...")
    }
    
    private func hideLoading() {
        // Скрываем индикатор загрузки
        print("Loading finished!")
    }
    
    private func setupNavigation() {
        let addAction = UIAction { _ in
            print("Add button tapped in Albums")
        }
        
        configureNavigation(
            title: Constants.Navigation.title,
            showButton: true,
            buttonImage: Constants.Navigation.buttonImageName,
            buttonAction: addAction
        )
    }
    
    private func loadData() {
        viewModel.loadData()
    }
}

// MARK: - Constants
extension AlbumsViewControllerWithCombine {
    enum Constants {
        enum Navigation {
            static let title = "Albums"
            static let buttonImageName = "plus"
        }
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumsViewControllerWithCombine: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Снимаем выделение с анимацией
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension AlbumsViewControllerWithCombine: UICollectionViewDataSource {
    
    // Определяет количество секций в коллекции
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    // Определяет количество ячеек в конкретной секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItems(in: section)
    }
    
    // Создает и настраивает ячейку для конкретной позиции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = viewModel.item(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: item.cellIdentifier,
            for: indexPath
        )
        
        configureCell(cell: cell, cellItem: item)
        return cell
    }
    
    private func configureCell(
        cell: UICollectionViewCell,
        cellItem: CellItemProtocol
    ) {
        switch cellItem.cellIdentifier {
        case MyAlbumsCell.identifier:
            guard let cell = cell as? MyAlbumsCell,
                  let myAlbum = cellItem as? MyAlbum else { return }
            
            cell.configuration(model: myAlbum)
            
        case SharedAlbumsFirstCell.identifier:
            guard let cell = cell as? SharedAlbumsFirstCell,
                  let firstShared = cellItem as? FirstSharedAlbum else { return }
            
            cell.configuration(model: firstShared)
            
        case SharedAlbumsCell.identifier:
            guard let cell = cell as? SharedAlbumsCell,
                  let shared = cellItem as? SharedAlbum else { return }
            
            cell.configuration(model: shared)
            
        case MediaTypesCell.identifier:
            guard let cell = cell as? MediaTypesCell,
                  let media = cellItem as? MediaAndOther else { return }
            
            cell.configuration(model: media)
            
        case OtherAlbumsCell.identifier:
            guard let cell = cell as? OtherAlbumsCell,
                  let media = cellItem as? MediaAndOther else { return }
            
            cell.configuration(model: media)
        default:
            break
        }
    }
    
    //MARK: - настройки хэдера
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: AlbumsHeaderView.identifier,
            for: indexPath
        ) as? AlbumsHeaderView else {
            return UICollectionReusableView()
        }
        
        header.configure(
            title: viewModel.headerTitle(for: indexPath.section) ?? "",
            buttonTitle: viewModel.headerButtonTitle(for: indexPath.section),
            buttonAction: { [weak self] in
                self?.viewModel.didTapHeaderButton(in: indexPath.section)
            }
        )
        
        return header
    }
}






