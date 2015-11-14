import Quick
import Nimble

@testable
import TDDWorkshop

class StreamItemDownloaderSpec: QuickSpec {
    override func spec() {
        describe("StreamItemDownloader") {
            var itemDownloader: StreamItemDownloader!

            var queryExecutor: QueryExecutor

            beforeEach {
                itemDownloader = StreamItemDownloader()
            }

            describe("download items") {

                context("when succeeds") {
                    beforeEach {
                        do {
                            itemDownloader.downloadItems {items in

                            }
                        } catch {

                        }
                    }
                    it("should call completion closure") {

                    }
                    it("should NOT throw error type") {

                    }
                }
                context("when fails") {

                    beforeEach {
                        do {
                            itemDownloader.downloadItems {items in

                            }
                        } catch {

                        }
                    }
                    it("should throw error type") {

                    }
                    it("should NOT call completion closure") {

                    }
                }
            }
        }
    }
}