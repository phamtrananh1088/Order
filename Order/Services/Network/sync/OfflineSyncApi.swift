//
//  OfflineSyncApi.swift
//  Order
//
//  Created by anh on 2024/11/11.
//

import Foundation
import Combine

class OfflineSyncApi {
    var baseApi : BaseApi
    init() {
        baseApi = BaseApi()
#if MOCK
        baseApi = MockBaseApi()
        #endif
        #if TOMOCK
baseApi = MockBaseApi()
#endif
        baseApi.builder = { urlBuilder in
            if #available(iOS 16, *) {
                urlBuilder.url.append(queryItems: [URLQueryItem(name: "api_key", value: Current.shared.user?.token ?? "")])
            } else {
                urlBuilder.url = urlBuilder.url.appendingPathComponent("&api_key=\(Current.shared.user?.token ?? "")")
            }
        }
    }
    
    func masterData(_ userInfo: UserInfo) -> AnyPublisher<Master, NetworkError> {
        return baseApi.post(endpoint: endpoint.masterData.rawValue, body: userInfo)
    }
    
    func postNotice(data: NoticePost) -> AnyPublisher<StateResult, NetworkError> {
        return baseApi.post(endpoint: endpoint.postNotice.rawValue, body: data)
    }
    
    func noticeData(userInfo: UserInfo) -> AnyPublisher<[Notice], NetworkError> {
        let noticeResult: AnyPublisher<NoticeResult, NetworkError> = baseApi.post(endpoint: endpoint.noticeData.rawValue, body: userInfo)
        return noticeResult
            .map { n in
                n.notices
            }
            .eraseToAnyPublisher()
    }
    
    enum endpoint: String {
        case masterData = "master/getdata"
        case postNotice = "notice/post"
        case noticeData = "notice/getdata"
    }
}
