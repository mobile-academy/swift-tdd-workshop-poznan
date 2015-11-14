//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

class StreamItemUploader {

    let parseAdapter: ParseAdapter
    var transformer = StreamItemTransformer()

    init (parseAdapter: ParseAdapter) {
        self.parseAdapter = parseAdapter
    }

    func uploadItem(streamItem: StreamItem, completion: (Bool, ErrorType?) -> ()) {
        let parseObject = transformer.parseObjectFromStreamItem(streamItem)
        parseAdapter.uploadObject(parseObject, completion: completion)
    }
}
