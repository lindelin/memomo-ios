//
//  NetworkService.swift
//  memomo
//
//  Created by Jie Wu on 2018/10/25.
//  Copyright © 2018 lindelin. All rights reserved.
//

import Foundation
import Moya

enum NetworkService {
    case memos
}

extension NetworkService: TargetType {
    var baseURL: URL { return URL(string: "http://memomo.test/api")! }
    var path: String {
        switch self {
        case .memos:
            return "/memos"
        }
    }
    var method: Moya.Method {
        switch self {
        case .memos:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .memos:
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .memos:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Authorization": OAuth.token()
        ]
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
