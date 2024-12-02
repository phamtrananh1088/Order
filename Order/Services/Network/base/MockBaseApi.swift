//
//  MockBaseApi.swift
//  Order
//
//  Created by anh on 2024/11/22.
//

import Foundation
import Combine

class MockBaseApi: BaseApi {
    lazy var mockDir: URL = {
        let mockDirectory = FileHelper.default.userDir.child(path: "mock")
        do {
            try FileManager.default.createDirectory(at: mockDirectory, withIntermediateDirectories: true)
        } catch {
            print("\(error)")
        }
        return mockDirectory
    }()
    
    func fileName(endpoint: String) -> String? {
        switch endpoint {
        case UserApi.endpoint.preLogin.rawValue:
            "prelogin.json"
        case UserApi.endpoint.login.rawValue:
            "login.json"
        case OfflineSyncApi.endpoint.noticeData.rawValue:
            "noticedata.json"
        case OfflineSyncApi.endpoint.postNotice.rawValue:
            "postNotice.json"
        default:
            nil
        }
    }
    
    override func post<T, R>(endpoint: String, body: T) -> AnyPublisher<R, NetworkError> where T : Codable, R : Codable {
        #if TOMOCK
        let r: AnyPublisher<R, NetworkError> = super.post(endpoint: endpoint, body: body)
        return r.map { data in
            if endpoint == OfflineSyncApi.endpoint.noticeData.rawValue, let d = data as? NoticeResult, d.notices.isEmpty {
                let c = Config.clientInfo.terminalId
                let r: [Notice] = [Notice(recordId: "a1", grdRecordId: "b1", eventRank: 2, noticeTitle: "info 1", noticeText: "notice 1", unreadFlag: true), Notice(recordId: "a2", grdRecordId: "b2", eventRank: 2, noticeTitle: "info 2", noticeText: "notice 2", unreadFlag: false), Notice(recordId: "a3", grdRecordId: "b3", eventRank: 1, noticeTitle: "info 3 {\(c)}", noticeText: "notice logout {INITIALIZE}", unreadFlag: true), Notice(recordId: "a4", grdRecordId: "b4", eventRank: 1, noticeTitle: "info 4 {\(c)}", noticeText: "notice restart ", unreadFlag: true)]
                let n: NoticeResult = NoticeResult(notices: r, clientInfo: nil)
                self.save(endpoint: endpoint, data: n)
                return n as! R
            }
            self.save(endpoint: endpoint, data: data)
            return data
        }
            .eraseToAnyPublisher()
#endif
        guard let filename = fileName(endpoint: endpoint) else {
            return super.post(endpoint: endpoint, body: body)
        }
        if let data: R = FileHelper.default.read(url: mockDir.child(path: filename)) {
            print("mockApi \(endpoint) \(mockDir.child(path: filename).path)")
            return Just(data).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
        } else {
            fatalError("mock prelogin")
        }
    }
    
    func save<T: Encodable>(endpoint: String, data: T) {
        guard let filename = fileName(endpoint: endpoint) else {
            return
        }
        FileHelper.default.createFile(url: mockDir.child(path: filename), data: data)
    }
}
