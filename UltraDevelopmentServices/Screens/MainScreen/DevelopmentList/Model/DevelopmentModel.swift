//
//  DevelopmentModel.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import Foundation

struct DevelopmentModel: Identifiable {
    let id = UUID()
    var dataId: String?
    var title: String?
    var description: String?
    var technology: String?
    var price: Double?
    var detailedPrice: Double?
    var imageURL: URL?
}

extension DevelopmentModel {
    init(dataId: String?, title: String?, description: String?, technology: String?, price: Double?, detailedPrice: Double?, imageURLString: String?) {
            self.dataId = dataId
            self.title = title
            self.description = description
            self.technology = technology
            self.price = price
            self.detailedPrice = detailedPrice
            
            // Связывание опциональной строки с URL
            if let imageURLString = imageURLString {
                self.imageURL = URL(string: "http://" + imageURLString)
            } else {
                self.imageURL = nil // В случае, если строка imageURLString пуста
            }
        }
}

// MARK: - Mock data

/// Это наши моки для вёрстки для DevelopmentModel
extension DevelopmentModel {

    static let mockData = DevelopmentModel(
        title: "Backend",
        description: "Разработка Backend для вашего проекта",
        technology: "Golang",
        price: 100000,
        detailedPrice: 10000,
        imageURL: .mockData
    )
}

/// Это наши моки для вёрстки для массива DevelopmentModel
extension [DevelopmentModel] {

    static let mockData = (1...20).map {
        DevelopmentModel(
            title: "Backend \($0)",
            description: "Разработка Backend для вашего проекта \($0)",
            price: Double($0*100000),
            imageURL: .mockData
        )
    }
}

/// Это наши мок фото из интернета.
private extension URL {

    static let mockData = URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music49/v4/bb/f8/45/bbf8450c-e014-5e75-b600-307f214d6814/859752920742_cover.jpg/1200x1200bf-60.jpg")
}
