//
//  ViewModelData.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import Foundation

struct NoticeModel: Identifiable {
    let id: String
    let title: String
    let content: String
    let isNew: Bool
    let useCase: NoticeUseCase
    
}
