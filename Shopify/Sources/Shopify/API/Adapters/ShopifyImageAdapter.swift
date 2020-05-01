//
//  ShopifyImageAdapter.swift
//  Shopify
//
//  Created by Evgeniy Antonov on 10/25/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import mobile_buy_sdk_ios
import ShopApp_Gateway

struct ShopifyImageAdapter {
    static func adapt(item: Storefront.Image?) -> Image? {
        guard let item = item else {
            return nil
        }

        let image = Image()
        image.id = item.id?.rawValue ?? ""
        image.src = item.originalSrc.absoluteString
        image.imageDescription = item.altText
        return image
    }
}
