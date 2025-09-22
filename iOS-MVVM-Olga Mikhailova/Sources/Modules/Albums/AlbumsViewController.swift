//
//  AlbumsViewController.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 18.09.2025.
//
import UIKit

final class AlbumsViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let presenter: AlbumsPresenterProtocol
    
    private lazy var albumsView: AlbumsView = {
        let view = AlbumsView { [weak self] sectionIndex in
            self?.presenter.layoutType(for: sectionIndex)
        }
        view.setupDataSource(dataSource: self)
        view.setupDelegate(delegate: self)
        return view
    }()
    
    //MARK: - Init
    init(presenter: AlbumsPresenterProtocol) {
        self.presenter = presenter
        
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
    }
    
    //MARK: - private methods
    
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
}

// MARK: - Constants
extension AlbumsViewController {
    enum Constants {
        enum Navigation {
            static let title = "Albums"
            static let buttonImageName = "plus"
        }
        
        //   static let backgroundColor: UIColor = .white
    }
}

// MARK: - AlbumsViewProtocol

extension AlbumsViewController: AlbumsViewProtocol {
    func reloadData() {
        albumsView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Снимаем выделение с анимацией
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    
    // Определяет количество секций в коллекции
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    // Определяет количество ячеек в конкретной секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presenter.numberOfItems(in: section)
    }
    
    // Создает и настраивает ячейку для конкретной позиции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = presenter.item(at: indexPath) else {
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
            title: presenter.headerTitle(for: indexPath.section) ?? "",
            buttonTitle: presenter.headerButtonTitle(for: indexPath.section),
            buttonAction: { [weak self] in
                self?.presenter.didTapHeaderButton(in: indexPath.section)
            }
        )
        
        return header
    }
}






