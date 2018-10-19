//
//  OAuth.swift
//  memomo
//
//  Created by Jie Wu on 2018/10/19.
//  Copyright © 2018 lindelin. All rights reserved.
//

import Foundation
import Moya

struct OAuth: Codable {
    
    static let clientId = 2
    static let clientSecret = "OB75oPNJk3tTGGZR509oMuIzVxrpp3ciMVsZ3KQ9"
    
    var tokenType: String
    var accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
    }
    
    static func login(email: String, password: String, callback: @escaping (OAuth?) -> Void) {
        let provider = MoyaProvider<OAuthService>()
        provider.request(.login(email: email, password: password)) { (result) in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let data = response.data
                    let coder = JSONDecoder()
                    let token = try! coder.decode(OAuth.self, from: data)
                    callback(token)
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
