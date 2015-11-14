//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import TDDWorkshop

class TestStreamItemCreatorDelegate: StreamItemCreatorDelegate {

    var capturedStreamItem: StreamItem?
    var capturedError: ErrorType?

    //MARK: StreamItemCreatorDelegate

    func creator(creator: StreamItemCreator, didCreateItem item: StreamItem) {
        capturedStreamItem = item
    }

    func creator(creator: StreamItemCreator, failedWithError error: ErrorType) {
        capturedError = error
    }

}
