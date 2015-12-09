//
//  AppMetaData.swift
//  YetiiLiib
//
//  Created by Joseph Duffy on 08/12/2015.
//  Copyright © 2015 Yetii Ltd. All rights reserved.
//

import Foundation

public struct AppMetaData {
    public let appId: Int
    public let bundleId: String
    public let name: String
    public let formattedPrice: String
    public let artworkURL60: NSURL
    public let artworkURL100: NSURL
    public let artworkURL512: NSURL

    public init?(rawInformation: [String : AnyObject]) {
        guard let appId = rawInformation["trackId"] as? Int else { return nil }
        guard let bundleId = rawInformation["bundleId"] as? String else { return nil }
        guard let name = rawInformation["trackName"] as? String else { return nil }
        guard let formattedPrice = rawInformation["formattedPrice"] as? String else { return nil }
        guard let artworkURL60String = rawInformation["artworkUrl60"] as? String else { return nil }
        guard let artworkURL60 = NSURL(string: artworkURL60String) else { return nil }
        guard let artworkURL100String = rawInformation["artworkUrl100"] as? String else { return nil }
        guard let artworkURL100 = NSURL(string: artworkURL100String) else { return nil }
        guard let artworkURL512String = rawInformation["artworkUrl512"] as? String else { return nil }
        guard let artworkURL512 = NSURL(string: artworkURL512String) else { return nil }

        self.appId = appId
        self.bundleId = bundleId
        self.name = name
        self.formattedPrice = formattedPrice
        self.artworkURL60 = artworkURL60
        self.artworkURL100 = artworkURL100
        self.artworkURL512 = artworkURL512
    }

    public func imageForSize(size: CGSize, scale: CGFloat = UIScreen.mainScreen().scale, callback: (UIImage?) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let minWidth = size.width * scale
            let minHeight = size.height * scale
            let minSize = max(minWidth, minHeight)

            let url: NSURL = {
                if minSize <= 60 {
                    return self.artworkURL60
                } else if minSize <= 100 {
                    return self.artworkURL100
                } else {
                    return self.artworkURL512
                }
            }()

            if let data = NSData(contentsOfURL: url), image = UIImage(data: data) {
                dispatch_async(dispatch_get_main_queue()) {
                    callback(image)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    callback(nil)
                }
            }
        }
    }
}