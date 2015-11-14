import Quick
import Nimble
import Parse

@testable
import TDDWorkshop

class StreamItemDownloaderSpec: QuickSpec {
    override func spec() {
        describe("StreamItemDownloader") {

            var itemDownloader: StreamItemDownloader!
            var parseAdapter: ParseAdapterFake!

            beforeEach {
                parseAdapter = ParseAdapterFake()
                itemDownloader = StreamItemDownloader(parseAdapter: parseAdapter)
            }

            describe("download items") {

                var downloadedItems: [StreamItem]?
                var capturedError: ErrorType?

                beforeEach {
                    itemDownloader.downloadItems {
                        items, error in
                        downloadedItems = items
                        capturedError = error
                    }
                }

                it("should execute query") {
                    expect(parseAdapter.capturedQuery).notTo(beNil())
                }
                it("should execute query to fetch StreamItem") {
                    let query = parseAdapter.capturedQuery!
                    expect(query.parseClassName) == "StreamItem"
                }

                context("when succeeds and completion is called") {
                    beforeEach {
                        let exampleObject = PFObject(className: "StreamItem")
                        exampleObject["title"] = "Foo"
                        exampleObject["image-data"] = NSData()
                        parseAdapter.capturedQueryCompletion?([exampleObject], nil)
                    }
                    it("should NOT pass error") {
                        expect(capturedError).to(beNil())
                    }
                    it("should return stream items") {
                        expect(downloadedItems).notTo(beNil())
                    }
                    it("should return single stream item") {
                        expect(downloadedItems!.count) == 1
                    }
                    it("should parse correctly title of the item") {
                        let streamItem = downloadedItems![0]
                        expect(streamItem.title) == "Foo"
                    }
                }
                context("when fails") {
                    beforeEach {
                        let error = NSError(domain: "Foo", code: 123, userInfo: nil)
                        parseAdapter.capturedQueryCompletion?(nil, error)
                    }
                    it("should pass an error") {
                        expect(capturedError).notTo(beNil())
                    }
                    it("should NOT return stream items") {
                        expect(downloadedItems).to(beNil())
                    }
                }
            }
        }
    }
}