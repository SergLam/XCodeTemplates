//___FILEHEADER___

import AppCenter
import AppCenterCrashes
// pod 'AppCenter', '~> 2.5.1'
// https://docs.microsoft.com/en-us/appcenter/sdk/crashes/ios
import BugfenderSDK
// pod 'BugfenderSDK', '~> 1.7'
// https://bugfender.com/
import FirebaseCrashlytics
// https://firebase.google.com/docs/crashlytics/upgrade-sdk?platform=ios
// pod 'Firebase'
// pod 'Firebase/Analytics'
import Foundation
import os

final class ___FILEBASENAMEASIDENTIFIER___ {
    
    static func testCrashCrashlytics() {
        #if DEBUG
        Crashlytics.sharedInstance().crash()
        #endif
    }
    
    static func testCrashAppCenter() {
        #if DEBUG
        MSCrashes.generateTestCrash()
        #endif
    }
    
    static func logWithTrace(_ errorMessage: String,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line) {
        #if DEBUG
        // NOTE: AdHoc config also will fails without if statement
        assertionFailure(errorMessage)
        #endif
        let error = AppInternalError.error(errorMessage: errorMessage)
        let logInfoString: String = "\(error.localizedDescription)\nfile: \(file)\nfunction: \(function)\nline: \(line)"
        os_log("%@", log: .error, type: .error, errorMessage)
        Crashlytics.crashlytics().log(logInfoString)
        Crashlytics.crashlytics().record(error: error.nsError)
        if UIApplication.shared.isRunningInTestFlightEnvironment() {
            let _ = Bugfender.sendIssueReturningUrl(withTitle: error.nsError.domain, text: logInfoString)
        }
    }
    
}
