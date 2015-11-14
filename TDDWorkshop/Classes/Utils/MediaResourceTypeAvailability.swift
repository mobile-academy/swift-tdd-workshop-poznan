//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

class ResourceTypeAvailability {

    //MARK: Public methods

    func photoLibraryAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
    }

    func cameraAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
}
