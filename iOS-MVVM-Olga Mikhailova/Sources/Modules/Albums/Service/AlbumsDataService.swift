//
//  AlbumsDataService.swift
//  MVP-Olga Mikhailova
//
//  Created by FoxxFire on 19.09.2025.
//
protocol AlbumsDataServiceProtocol {
    func getAllSections() -> [AlbumSection]
    func getSection(at index: Int) -> AlbumSection?
    func getSectionType(at index: Int) -> SectionType?
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
    
    func getSection(at index: Int) -> AlbumSection? {
        let sections = getAllSections()
        guard index < sections.count else { return nil }
        return sections[index]
    }
    
    func getSectionType(at index: Int) -> SectionType? {
        return getSection(at: index)?.type
    }
    
}

