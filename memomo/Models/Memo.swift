//
//  Memo.swift
//  memomo
//
//  Created by Jie Wu on 2018/10/25.
//  Copyright © 2018 lindelin. All rights reserved.
//

import Foundation
import Moya

struct Memo: Codable {
    var id: Int
    var title: String
    var contents: String
    var userId: Int
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case contents
        case userId = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    static func list(callback: @escaping ([Memo]?) -> Void) {
        let provider = MoyaProvider<NetworkService>()
        provider.request(.memos) { (result) in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let data = response.data
                    let coder = JSONDecoder()
                    let memos = try! coder.decode([Memo].self, from: data)
                    callback(memos)
                }
                catch {
                    print("error", error)
                    callback(nil)
                }
            // do something with the response data or statusCode
            case let .failure(error):
                print("error", error)
                callback(nil)
            }
        }
    }
}
