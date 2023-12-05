//
//  SongEntity.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import Foundation

struct GetAllDevelopmentServicesResponse: Decodable {
    let development_services: [DevelopmentService]
    
    enum CodingKeys: String, CodingKey {
            case development_services
        }
}

struct DevelopmentService: Decodable {
    let uuid: String
    let Title: String?
    let Description: String?
    let image_url: String?
    let Price: Double?
    let RecordStatus: UInt
    let Technology: String?
    let DetailedPrice: Double?
    
    enum CodingKeys: String, CodingKey {
            case uuid,
                 Title,
                 Description,
                 image_url,
                 Price,
                 RecordStatus,
                 Technology,
                 DetailedPrice
        }
}

extension DevelopmentService {
    var mapper: DevelopmentModel {
            return DevelopmentModel(
                dataId: uuid,
                title: Title,
                description: Description,
                technology: Technology,
                price: Price,
                detailedPrice: DetailedPrice,
                imageURLString: image_url
            )
        }
}
