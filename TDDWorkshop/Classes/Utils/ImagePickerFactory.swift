//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerFactory {
    func createPickerWithSourceType(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController
}

class DefaultImagePickerFactory: ImagePickerFactory {
    func createPickerWithSourceType(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        return picker
    }
}
