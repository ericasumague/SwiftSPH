//
//  RequestService.swift
//  SPHTechExam
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

class RequestService {
    
    static let shared = RequestService()
    
    func sendRequest(urlString: String?, success: @escaping (String) -> Void, errorFailure: @escaping (Error) -> Void) -> Void {
        
        
        let url = URL (string: urlString!)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            let parser = JSONParser()
            if let data = data {
                parser.parseQuarterAndSave(data: data)
                success("Success")
            }
            
            if let error = error {
                errorFailure(error)
            }
            
            }.resume()
    }
    
}
