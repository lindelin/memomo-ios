//
//  AuthService.swift
//  memomo
//
//  Created by Jie Wu on 2018/10/19.
//  Copyright © 2018 lindelin. All rights reserved.
//

import Foundation
import Moya

enum OAuthService {
    case login(email: String, password: String)
}

extension OAuthService: TargetType {
    var baseURL: URL { return URL(string: "http://memomo.test")! }
    var path: String {
        switch self {
        case .login:
            return "/oauth/token"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(parameters: [
                "grant_type": "password",
                "client_id": OAuth.clientId,
                "client_secret": OAuth.clientSecret,
                "username": email,
                "password": password,
                "scope": "*"
                ], encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .login:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
