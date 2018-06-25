//
//  LocalizationManager.swift
//  RoomBooking
//
//  Created by Onur Torna on 25/06/18.
//

import Foundation

final class LocalizationManager {
    private enum Const {
        static let languageFileExtension = "lproj"
    }

    enum Language: String {
        case English = "en"

        var localeIdentifier: String {
            switch self {
            case .English:
                return LocaleIdentifier.English.rawValue
            }
        }
    }

    private enum LocaleIdentifier: String {
        case English = "en_EN"
    }

    /// Singleton shared instance
    static let shared = LocalizationManager(with: .English)

    /// Bundle of the localization manager instance
    var bundle: Bundle

    /// Locale of the localization manager instance
    var locale: Locale

    /// Current language of the localization manager instance
    var currentLanguage: Language {
        didSet {
            bundle = LocalizationManager.updateBundle(with: currentLanguage)
            locale = Locale(identifier: currentLanguage.localeIdentifier)
        }
    }

    init(with language: Language) {
        currentLanguage = language
        bundle = LocalizationManager.updateBundle(with: language)
        locale = Locale(identifier: language.localeIdentifier)
    }

    /// Switches current selected language
    func switchLanguage() {
        // FIXME: Switch option can be added when new language option comes
    }

    // MARK: - Helpers

    @discardableResult private static func updateBundle(with language: Language) -> Bundle {

        let path = Bundle(for: LocalizationManager.self).path(forResource: language.rawValue,
                                                              ofType: Const.languageFileExtension) ?? ""
        return Bundle(path: path) ?? Bundle.main
    }
}

