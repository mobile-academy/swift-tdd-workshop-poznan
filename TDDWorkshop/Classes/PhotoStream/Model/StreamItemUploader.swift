//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

class StreamItemUploader {

    let parseAdapter: ParseAdapter
    var transformer = StreamItemTransformer()

    //MARK: Object Life Cycle

    init (parseAdapter: ParseAdapter) {
        self.parseAdapter = parseAdapter
    }

    //MARK: Public methods

    func uploadItem(streamItem: StreamItem, completion: (Bool, ErrorType?) -> ()) {
        let parseObject = transformer.parseObjectFromStreamItem(streamItem)
        parseAdapter.uploadObject(parseObject, completion: completion)
    }
}
