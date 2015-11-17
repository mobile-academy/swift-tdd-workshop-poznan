import Quick
import Nimble

@testable
import TDDWorkshop

class StreamItemViewControllerSpec: QuickSpec {
    override func spec() {
        describe("StreamItemViewController") {
            var viewController: StreamItemViewController!

            beforeEach {
                let storyboard = UIStoryboard(name: "StreamItemPreview", bundle: nil)
                viewController = storyboard.instantiateViewControllerWithIdentifier("StreamItemPreview") as! StreamItemViewController
            }
            it("should work") {
                expect(viewController).notTo(beNil())
            }
        }
    }
}