//
//  AlbumsSections.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 18.09.2025.
//
import Foundation

//MARK: - Section Type

enum SectionType: String, CaseIterable {
    case myAlbums = "My Albums"
    case sharedAlbums = "Shared Albums"
    case mediaTypes = "Media Types"
    case other = "Other"
}

//MARK: - Section Model

struct AlbumSection {
    let header: SectionHeader  // Заголовок секции
    let type: SectionType      // Тип секции (для layout)
    let items: [CellItemProtocol]     // ✅ Массив ВСЕХ ячеек этой секции
}
