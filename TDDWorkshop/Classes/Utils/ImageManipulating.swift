//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import UIImage_Resize

protocol ImageManipulating {
    func scaleImage(image: UIImage, width: Float) -> UIImage

    func dataFromImage(image: UIImage, quality: Float) -> NSData
    func imageFromData(data: NSData) -> UIImage
}

class DefaultImageManipulator: ImageManipulating {

    func scaleImage(image: UIImage, width: Float) -> UIImage {
        let size = CGSize(width: 300, height: 300)
        return image.resizedImageToSize(size)
    }

    func dataFromImage(image: UIImage, quality: Float) -> NSData {
        return UIImageJPEGRepresentation(image, CGFloat(quality))!
    }

    func imageFromData(data: NSData) -> UIImage {
        return UIImage(data: data)!
    }

}
