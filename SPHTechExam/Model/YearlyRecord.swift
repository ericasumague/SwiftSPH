//
//  YearlyRecord.swift
//  SPHTechExam
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

public struct YearlyRecord {
    var year: String
    var quarterRecords: [UsageYearly] = []
    
    
    var totalVolume: Double {
        let volume = Array(Set(quarterRecords.map{ $0.volume }))
        
        var totalVolume: Double = 0
        
        for (_, vol) in volume.enumerated() {
            totalVolume += Double(vol) ?? 0.0
        }
        
        return round(totalVolume * 1_000_000) / 1_000_000
    }
    
    var hasDescreasingVolume: Bool {
        let volume = Array(Set(quarterRecords.map{ $0.volume }))

        var initialVolume: Double = Double(volume[0]) ?? 0.0
        for (_, vol) in volume.enumerated() {
            
            let volDouble = Double(vol) ?? 0.0
            if volDouble < initialVolume {
                return true
            } else {
                initialVolume = volDouble
            }
        }
        return false
    }
    
    var volumeDifference: Double {
        let volume = Array(Set(quarterRecords.map{ $0.volume }))
        
        var initialVolume: Double = Double(volume[0]) ?? 0.0
        for (_, vol) in volume.enumerated() {
            
            let volDouble = Double(vol) ?? 0.0
            if volDouble < initialVolume {
                let diff = initialVolume - volDouble
                return round(diff * 1_000_000) / 1_000_000
            } else {
                initialVolume = volDouble
            }
        }
        return 0.0
    }
}
