//
//  String+Extenstions.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import Foundation

extension String {
    
    var toURL: URL? { URL(string: self) }
}
