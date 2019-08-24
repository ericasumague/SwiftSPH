//
//  MobileDataUsageViewModel.swift
//  SPHTechExam
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

class MobileDataUsageViewModel {
    
    var requestService: RequestService?
    
    
    init(requestService: RequestService) {
        self.requestService = requestService
    }
    
    func loadData() {
        let quarterlyData = UsageQuarterly.mr_findAll()
        
        if quarterlyData!.count == 0 {
            
            let jsonURLString = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
            
            self.requestService?.sendRequest(urlString: jsonURLString, success: { (success) in
                self.convertDataToYearly()
            }, errorFailure: { (error) in
                print(error.localizedDescription)
            })
            
        } else {
            let yearlyData = UsageYearly.mr_findAll()
            if yearlyData!.count == 0 {
                self.convertDataToYearly()
            }
        }
    }
    
    private func convertDataToYearly() {
        let quarterlyData: [UsageQuarterly] = UsageQuarterly.mr_findAll() as! [UsageQuarterly]
        
        for quarterly: UsageQuarterly in quarterlyData {
            let quarter = quarterly.quarter?.split(separator: "-")
            
            let separatedYear = String(quarter?.first ?? "")
            let separatedQuarter = String(quarter?.last ?? "")

            if let yearly = UsageYearly.mr_createEntity() {
                yearly.quarter = separatedQuarter
                yearly.year = separatedYear
                yearly.volume = quarterly.volume_of_mobile_data!
                NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
            }
        }
    }
    
    func yearlyData(completionBlock: @escaping ([YearlyRecord]) -> Void) -> Void {
        let yearlyData: [UsageYearly] = UsageYearly.mr_findAll() as! [UsageYearly]
        let years = Array(Set(yearlyData.map{ $0.year })).sorted()
        
        var yearlyRecord: [YearlyRecord] = []
        
        for (_,year) in years.enumerated() {
            let yearPredicate = NSPredicate(format: "year = %@", year)
            let filteredByYearList: [UsageYearly] = UsageYearly.mr_findAllSorted(by: "quarter", ascending: true, with: yearPredicate) as! [UsageYearly]
            
            let yearRecord = YearlyRecord(year: year, quarterRecords: filteredByYearList)
            yearlyRecord.append(yearRecord)
        }
        
        completionBlock(yearlyRecord)
    }
}
