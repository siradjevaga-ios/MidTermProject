//
//  AppData.swift
//  MidTermProject
//
//  Created by user on 13.01.26.
//

import Foundation

final class AppData {
    static let shared = AppData()
    private init() {}
    let cartViewModel = CartViewModel()
}
