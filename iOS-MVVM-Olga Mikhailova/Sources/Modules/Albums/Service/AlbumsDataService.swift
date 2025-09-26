//
//  AlbumsDataService.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 19.09.2025.
//
import Foundation

protocol AlbumsDataServiceProtocol {
    func getAllSections() -> [AlbumSection]
}

class AlbumsDataService: AlbumsDataServiceProtocol {
    
    func getAllSections() -> [AlbumSection] {
        return [
            createMyAlbumsSection(),
            createSharedAlbumsSection(),
            createMediaTypesSection(),
            createOtherSection()
        ]
    }
    
    func createMyAlbumsSection() -> AlbumSection {
        return AlbumSection (
            header: SectionHeader(
                title: "My Albums",
                buttonTitle: "See All"
            ),
            type: .myAlbums,
            items: MyAlbum.myAlbums
        )
    }
    
    func createSharedAlbumsSection() -> AlbumSection {
        return AlbumSection(
            header: SectionHeader(
                title: "Shared Albums",
                buttonTitle: "See All"
            ),
            type: .sharedAlbums,
            items: [
                FirstSharedAlbum.firstSharedAlbum
            ] + SharedAlbum.sharedAlbums
        )
    }
    
    func createMediaTypesSection() -> AlbumSection {
        return AlbumSection(
            header: SectionHeader(
                title: "Media Types",
                buttonTitle: nil
            ),
            type: .mediaTypes,
            items: MediaAndOther.mediaTypes
        )
    }
    
    func createOtherSection() -> AlbumSection {
        return AlbumSection(
            header: SectionHeader(
                title: "Other",
                buttonTitle: nil
            ),
            type: .other,
            items: MediaAndOther.otherType
        )
    }
}

