//
//  JSONParser.swift
//  SPHTechExam
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

class JSONParser {
    
    func parse<T>(data: Data) -> T? where T : Codable {
        return nil
    }
    
    func parseQuarterAndSave(data: Data) {
        
        do {
            
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
            guard let result = json["result"] else { return }
            
            let resultData = try JSONSerialization.data(withJSONObject: result, options: [])
            
            do {
                let recordData = try JSONSerialization.jsonObject(with: resultData, options: []) as? [String: Any]
                let records: [[String: Any]] = recordData!["records"] as! [[String : Any]]
                print("records \(records)")
                
                
                for record in records {
                    MagicalRecord.save ({ (localContext) in
                        _ = UsageQuarterly.mr_import(from: record, in: localContext)
                    })
                }
                
            } catch let jsonError {
                print("JSON Parsing", jsonError)
            }

        } catch let jsonError {
            print("JSON Parsing", jsonError)
        }
    }
}
