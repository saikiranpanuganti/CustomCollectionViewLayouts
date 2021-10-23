//
//  NetworkAdaptor.swift
//  ChromeCastProject
//
//  Created by SaiKiran Panuganti on 06/06/21.
//

import Foundation

import Foundation

class NetworkAdaptor {
    static func request(url: String?, method: HTTPMethod, headers: [String: String]? = nil, urlParameters: [String: String]? = nil, bodyParameters: [String: Any]? = nil, completionHandler:@escaping ((Data?, URLResponse?, Error?)->Void)) {
        guard var urlString = url else {
            completionHandler(nil, nil, nil)
            return
        }
        
        if let urlParameters = urlParameters {
            let parametersString = (urlParameters.compactMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }) as Array).joined(separator: "&")
            
            urlString = urlString + "?" + parametersString
        }
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil, nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let parameters = bodyParameters {
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = httpBody
            }catch {
                completionHandler(nil, nil, error)
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            completionHandler(data, response, error)
        }.resume()
    }
}
