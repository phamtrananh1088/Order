//
//  BaseApi.swift
//  Order
//
//  Created by anh on 2024/11/12.
//

import Foundation
import Combine
import UniformTypeIdentifiers

class BaseApi {
    var builder: ((URLBuilder) -> Void)?
    
    init() {
    
    }

    func post<T: Codable, R: Codable>(endpoint: String, body: T) -> AnyPublisher<R, NetworkError> {
        let urlBuilder = URLBuilder(endpoint: endpoint)
        builder?(urlBuilder)
        let url = urlBuilder.url
        
        let urlRequest = URLRequestBuilder(urlRequest: URLRequest(url: url))
            .setMethodPost()
            .setContentTypeJson()
            .setBodyJson(body)
            .urlRequest
        debugPrint(urlRequest)
        let task = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 404 {
                        debugPrint(httpResponse)
                        throw NetworkError.resourceNotFound
                    } else if httpResponse.statusCode != 200 {
                        debugPrint(httpResponse)
                        throw NetworkError.serverError
                    }
                }
                
                return data
            }
            .decode(type: R.self, decoder: JSONDecoder())
            .mapError {
                if let err = $0 as? NetworkError {
                    return err
                }
                if let err = $0 as? URLError {
                    return NetworkError.urlError(err: err)
                }
                #if DEBUG
                if let err = $0 as? DecodingError {
                    print(err)
                }
                #endif
                return NetworkError.otherError(err: $0)
            }
            .eraseToAnyPublisher()
        
        return task
    }
    class URLBuilder {
        var url: URL
        init(endpoint: String) {
            self.url = URL(string: Config.env.api + endpoint)!
        }
        
        func addApiKey(key apiKey: String) -> Self {
            if #available(iOS 16, *) {
                url.append(queryItems: [URLQueryItem(name: "api_key", value: Config.env.app_center_key)])
            } else {
                url = url.appendingPathComponent("&api_key=\(apiKey)")
            }
            return self
        }
    }
    internal class URLRequestBuilder {
        var urlRequest: URLRequest
        init(urlRequest: URLRequest) {
            self.urlRequest = urlRequest
        }
        func setMethodPost() -> Self {
            urlRequest.httpMethod = "POST"
            return self
        }
        func setContentTypeJson() -> Self {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return self
        }
        func setBodyJson<T: Encodable>(_ body: T) -> Self {
            let jsonEncoder = JSONEncoder()
            let _body = try? jsonEncoder.encode(body)
            urlRequest.httpBody = _body
            return self
        }
        private func mimeType(for path: String) -> String {
            let url = NSURL(fileURLWithPath: path)
            let pathExtension = url.pathExtension

            if let pathExtension = pathExtension, let mimeType = UTType(filenameExtension: pathExtension)?.preferredMIMEType {
                return mimeType
            }
            return "application/octet-stream"
        }
        func setPartFormData(texts: Dictionary<String, Encodable>, files: Dictionary<String, String>) throws -> Self {
            let boundary = UUID().uuidString
            var body = Data()
            
            for (key, value) in texts {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition:form-data; name=\"\(key)\"\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
            
            for (key, path) in files {
                let url = URL(fileURLWithPath: path)
                let filename = url.lastPathComponent
                guard let data = try? Data(contentsOf: url) else {
                    throw NSError()
                }
                _ = mimeType(for: path)
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition:form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                body.append(data)
                body.append("\r\n".data(using: .utf8)!)
            }
            
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            urlRequest.httpBody = body
            return self
        }
    }
}
