//
//  StringTable.swift
//  RoomBooking
//
//  Created by Onur Torna on 25/06/18.
//

import Foundation

enum StringTable: String {

    case commons = "Commons"
    case landingPage = "LandingPage"

    /// Returns localized key with the current selected app language
    ///
    /// - Parameter key: Localization key
    /// - Returns: Localized value
    func localized(key: String?) -> String {
        guard let key = key else {
            return ""
        }
        return NSLocalizedString(key,
                                 tableName: rawValue,
                                 bundle: LocalizationManager.shared.bundle,
                                 value: key,
                                 comment: "")
    }

    /// Localizes and formats given String with arguments
    ///
    /// - Parameters:
    ///   - formatKey: String to be formatted
    ///   - arguments: Arguments to apply
    /// - Returns: Formatted localized string
    func localized(format formatKey: String, arguments: String...) -> String {
        let format = localized(key: formatKey)
        return String(format: format, arguments)
    }
}
