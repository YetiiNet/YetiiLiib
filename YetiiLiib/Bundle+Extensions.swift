//
//  Utilities.swift
//  YetiiLiib
//
//  Created by Joseph Duffy on 07/12/2015.
//  Copyright © 2015 Yetii Ltd. All rights reserved.
//

import Foundation

private class InternalClass {}

extension Bundle {
    @nonobjc
    internal static let framework = Bundle(for: InternalClass.self)

    public var appName: String? {
        if let appName = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            // Localised app name
            return appName
        } else if let appName = object(forInfoDictionaryKey: "CFBundleName") as? String {
            // Regular app name
            return appName
        } else if let appName = object(forInfoDictionaryKey: "CFBundleExecutable") as? String {
            // Executable name
            return appName
        } else {
            return nil
        }
    }

    public var appVersion: String {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }

    public var appBuild: String {
        return object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }

    internal var appIcon: UIImage? {
        return UIImage(named: "App Icon 128pt", in: self, compatibleWith: nil)
    }
}