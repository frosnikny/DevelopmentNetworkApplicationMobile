//
//  MainViewModel.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import Foundation

/// Это наш собственный протокол, в котором мы будем прописывать функции, которые мы должны реализовать дальше. Например, пользователь нажал на кнопку лайка. Тогда мы добавим func tapLike(id: Int)
protocol MainViewModelProtocol {
    func seachTitles(searchText: String) -> [DevelopmentModel]
//    func pressedLike(trackID: Int, isLiked: Bool, completion: (() -> Void)?)
    func getDevs(completion: @escaping (Error?) -> Void) /// Новая фукнция
}

/// Это наш основной класс, который будет хранить все треки, полученные из АПИ.
/// Слово final говорит, что это конечный класс и наследоваться от него мы не будем
final class MainViewModel: ObservableObject {

    @Published var developmentServices: [DevelopmentModel] = []
}

// MARK: - MainViewModelProtocol

/// Подписываемся на наш протокл, где в дальнейшем будем реализовывать функции
extension MainViewModel: MainViewModelProtocol {

    /// Получение треков
    /// - Parameter completion: комлишн блок с ошибкой, если она есть
    func getDevs(completion: @escaping (Error?) -> Void) {
        APIManager.shared.getTracks { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                developmentServices = data
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    /// Фильтрация при поиске
    /// - Parameter searchText: текст из сёрч бара
    /// - Returns: массив отфильтрованных услуг по разработке
    func seachTitles(searchText: String) -> [DevelopmentModel] {
        searchText.isEmpty
        ? developmentServices
        : developmentServices.filter {
            ($0.title ?? "Название не указано").contains(searchText)
        }
    }

}
