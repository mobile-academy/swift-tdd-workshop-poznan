//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import Parse

class StreamItemDownloader {

    let parseAdapter: ParseAdapter
    var transformer = StreamItemTransformer()

    //MARK: Object Life Cycle

    init(parseAdapter: ParseAdapter) {
        self.parseAdapter = parseAdapter
    }

    //MARK: Public methods

    func downloadItems(completion: ([StreamItem]?, ErrorType?) -> ()) {

        let query = PFQuery(className:StreamItem.entityName)

        parseAdapter.executeQuery(query) {[weak self] objects, error in
            guard error == nil,
            let parseObjects = objects else  {
                completion(nil, error)
                return
            }
            var streamItems = [StreamItem]()
            for object in parseObjects {
                if let streamItem = self?.transformer.streamItemFromParseObject(object) {
                    streamItems.append(streamItem)
                }
            }
            completion(streamItems, nil)
        }
    }

}
