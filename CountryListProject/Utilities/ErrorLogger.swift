import Foundation

struct ErrorLogger {
    static func logError(_ errorMessage: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = formatter.string(from: Date.init())
        let errorLog = "\(timestamp) ~ [Error Message]: \(errorMessage)"
        print(errorLog)
    }
}
