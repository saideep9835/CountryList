//
//  ErrorLogger.swift
//  CountryListProject
//
//  Created by Saideep Reddy Talusani on 4/18/25.
//


import Foundation

struct ErrorLogger {
    static func logError(_ errorMessage: String, function: String = #function, file: String = #file, line: Int = #line) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = formatter.string(from: Date())

        let fileName = (file as NSString).lastPathComponent
        let log = """
        [ERROR] \(timestamp)
        Message: \(errorMessage)
        Function: \(function)
        File: \(fileName):\(line)
        """
        print(log)
    }
}

