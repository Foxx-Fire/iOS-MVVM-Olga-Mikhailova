//
//  CellItemProtocol.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 18.09.2025.
//
import Foundation

// MARK: - Базовый протокол для всех элементов ячеек
protocol CellItemProtocol {
    var cellIdentifier: String { get }
    var itemId: String { get }
}

//  MARK: - Model

struct MyAlbum: CellItemProtocol{
    let imageName: String
    let title: String
    let count: Int
    var cellIdentifier: String { "MyAlbumsCell" }
    var itemId: String {"myAlbum_\(title)"}
}

struct FirstSharedAlbum: CellItemProtocol {
    let imageNames: [String]
    let title: String
    let subtitle: String
    var cellIdentifier: String { "SharedAlbumsFirstCell" }
    var itemId: String {"firstSharedAlbum_\(title)"}
}

struct SharedAlbum: CellItemProtocol {
    let imageName: String
    let title: String
    let subtitle: String
    var cellIdentifier: String { "SharedAlbumsCell" }
    var itemId: String {"sharedAlbum_\(title)"}
}

struct MediaAndOther: CellItemProtocol {
    let imageName: String
    let title: String
    let count: Int
    let chevronName: String
    var cellIdentifier: String { "MediaTypesCell" }
    var itemId: String {"mediaAndOther_\(title)"}
}

struct SectionHeader {
    let title: String
    let buttonTitle: String?
}


