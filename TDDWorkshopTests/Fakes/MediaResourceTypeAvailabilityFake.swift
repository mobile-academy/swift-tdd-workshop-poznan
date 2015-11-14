//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import TDDWorkshop

class MediaResourceTypeAvailabilityFake: ResourceTypeAvailability {

    var fakePhotoLibraryAvailability = false
    var fakeCameraAvailability = false

    override func photoLibraryAvailable() -> Bool {
        return fakePhotoLibraryAvailability
    }

    override func cameraAvailable() -> Bool {
        return fakeCameraAvailability
    }

}
