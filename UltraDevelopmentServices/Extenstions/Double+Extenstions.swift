//
//  Double+Extenstions.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import Foundation

extension Double? {

    var toString: String? {
        guard let self else { return nil }
        return "\(self)"
    }
}
