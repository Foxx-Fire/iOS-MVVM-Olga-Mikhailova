//
//  AlbumsView.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 18.09.2025.
//

import UIKit

final class AlbumsView: UIView {
    
    // MARK: - UI Elements
    
    private let collectionView: UICollectionView
    private let layout: AlbumCompositionalLayout
    private var getLayoutType: (Int) -> AlbumCompositionalLayout.LayoutType?
    
    // MARK: - Init
    
    init(getLayoutType: @escaping (Int) -> AlbumCompositionalLayout.LayoutType?) {
        self.getLayoutType = getLayoutType
        self.layout = AlbumCompositionalLayout()
        let compositionalLayout = layout.createLayout {
            sectionIndex in
            return getLayoutType(sectionIndex)
        }
        self.collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: compositionalLayout
        )
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        setupConstraints()
        registerCollectionViewCells()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Public methods
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func setupDataSource(dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func setupDelegate(delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
    
    // MARK: - Registration
    
    private func registerCollectionViewCells() {
        collectionView.register(
            MyAlbumsCell.self,
            forCellWithReuseIdentifier: MyAlbumsCell.identifier
        )
        collectionView.register(
            AlbumsHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AlbumsHeaderView.identifier
        )
        collectionView.register(
            SharedAlbumsFirstCell.self,
            forCellWithReuseIdentifier: SharedAlbumsFirstCell.identifier
        )
        collectionView.register(
            SharedAlbumsCell.self,
            forCellWithReuseIdentifier: SharedAlbumsCell.identifier
        )
        collectionView.register(
            MediaTypesCell.self,
            forCellWithReuseIdentifier: MediaTypesCell.identifier
        )
        collectionView.register(
            OtherAlbumsCell.self,
            forCellWithReuseIdentifier: OtherAlbumsCell.identifier
        )
    }
}

