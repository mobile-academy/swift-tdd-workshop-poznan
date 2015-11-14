import Quick
import Nimble
import Parse

@testable
import TDDWorkshop

class StreamItemTransformerSpec: QuickSpec {
    override func spec() {

        describe("StreamItemTransformer") {
            var transformer: StreamItemTransformer!

            beforeEach {
                transformer = StreamItemTransformer()
            }

            describe("transform stream item into Parse object") {
                var parseObject: PFObject!
                var streamItem: StreamItem!
                var fakeImageData = NSData()

                beforeEach {
                    streamItem = StreamItem(title: "Foo 123", imageData: fakeImageData)
                    parseObject = transformer.parseObjectFromStreamItem(streamItem)
                }
                it("should set title under 'title' key") {
                    let title = parseObject["title"] as? String
                    expect(title).notTo(beNil())
                    expect(title!) == "Foo 123"
                }
                it("should set image data under 'image-data' key") {
                    let data = parseObject["image-data"] as? NSData
                    expect(data).notTo(beNil())
                    expect(data!) == fakeImageData
                }
            }

            describe("transform parse object into Stream Item") {
                var streamItem : StreamItem?
                var parseObject : PFObject!
                var fakeImageData = NSData()

                beforeEach {
                    streamItem = nil
                    parseObject = PFObject(className: "StreamItem")
                }
                context("when it has title and image data") {
                    beforeEach {
                        parseObject["title"] = "Foo Bar"
                        parseObject["image-data"] = fakeImageData
                        streamItem = transformer.streamItemFromParseObject(parseObject)
                    }
                    it("should create Stream Item") {
                        expect(streamItem).notTo(beNil())
                    }
                    it("should set proper title on Stream Item") {
                        expect(streamItem!.title) == "Foo Bar"
                    }
                    it("should set image data on Stream Item") {
                        expect(streamItem!.imageData) == fakeImageData
                    }
                }
                context("when it does NOT have title") {
                    beforeEach {
                        parseObject["image-data"] = NSData()
                        streamItem = transformer.streamItemFromParseObject(parseObject)
                    }
                    it("should NOT create Stream Item") {
                        expect(streamItem).to(beNil())
                    }
                }
                context("when it does NOT have image data") {
                    beforeEach {
                        parseObject["title"] = "Foo Bar"
                        streamItem = transformer.streamItemFromParseObject(parseObject)
                    }
                    it("should NOT create Stream Item") {
                        expect(streamItem).to(beNil())
                    }
                }
                context("when it does NOT have title, NOR image data") {
                    beforeEach {
                        streamItem = transformer.streamItemFromParseObject(parseObject)
                    }
                    it("should NOT create Stream Item") {
                        expect(streamItem).to(beNil())
                    }
                }
            }
        }
    }
}