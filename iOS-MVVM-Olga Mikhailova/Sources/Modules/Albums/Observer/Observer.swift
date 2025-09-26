
  Dynamic.swift
  iOS-MVVM-Olga Mikhailova

  Created by FoxxFire on 23.09.2025.


import Foundation

class Observable<T> {
    typealias Observer = (T) -> Void
    private var observer: Observer? // ? - может быть nil (если никто не подписан)

    /*
     // Без typealias:
     private var observer: ((String) -> Void)?

     // С typealias (более читаемо):
     private var observer: Observer?
     */

    func bind(observer: Observer?) {
        self.observer = observer // сохраняем наблюдателя
        observer?(value) // сразу вызываем с текущим значением
    }

    var value: T {
        didSet {
            observer?(value) // вызываем наблюдателя при изменении
        }
    }

    init(_ initialValue: T) {
        value = initialValue
    }
}
