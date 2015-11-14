//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol ImageManipulator {
    func scaleImage(image: UIImage, width: Float) -> UIImage

    func dataFromImage(image: UIImage, quality: Float) -> NSData
    func imageFromData(data: NSData) -> UIImage
}

class DefaultImageManipulator: ImageManipulator {

    func scaleImage(image: UIImage, width: Float) -> UIImage {
        return image //TODO
    }

    func dataFromImage(image: UIImage, quality: Float) -> NSData {
        return UIImageJPEGRepresentation(image, CGFloat(quality))!
    }

    func imageFromData(data: NSData) -> UIImage {
        return UIImage(data: data)!
    }

}
