//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol Query {}

protocol QueryResult {}

protocol QueryExecutor {
    func executeQuery(query: Query, completion:(QueryResult) -> ()) throws
}

class StreamItemDownloader {

    var queryExecutor: QueryExecutor

    init(queryExecutor: QueryExecutor) {
        self.queryExecutor = queryExecutor
    }

    func downloadItems(completion: ([StreamItem]) -> ()) throws {
        //TODO create Parse query
        //TODO execute
        //TODO transform response to stream items
    }
}
