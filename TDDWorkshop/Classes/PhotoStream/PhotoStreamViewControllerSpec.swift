import Quick
import Nimble

@testable
import TDDWorkshop

class PhotoStreamViewControllerSpec: QuickSpec {
    override func spec() {
        describe("PhotoStreamViewController") {
            var viewController: PhotoStreamViewController!

            var downloader: StreamItemDownloaderFake!
            var uploader: StreamItemUploaderFake!
            var creator: StreamItemCreatorFake!
            var imageManipulator: ImageManipulatorFake!

            beforeEach {
                downloader = StreamItemDownloaderFake()
                uploader = StreamItemUploaderFake()
                creator = StreamItemCreatorFake()
                imageManipulator = ImageManipulatorFake()

                let storyboard = UIStoryboard(name: "PhotoStream", bundle: nil)
                viewController = storyboard.instantiateViewControllerWithIdentifier("PhotoStream") as! PhotoStreamViewController

                viewController.downloader = downloader
                viewController.uploader = uploader
                viewController.creator = creator
                viewController.imageManipulator = imageManipulator
            }

            describe("when view loads") {
                beforeEach {
                    viewController.viewDidLoad()
                }
                it("should download stream items") {
                    expect(downloader.downloadItemsCalled) == true
                }
                context("when download finishes") {
                    var refreshControlFake: UIRefreshControlFake!
                    var collectionViewFake : UICollectionViewFake!

                    beforeEach {
                        collectionViewFake = UICollectionViewFake(frame: CGRectZero,
                                collectionViewLayout: UICollectionViewFlowLayout())
                        refreshControlFake = UIRefreshControlFake()

                        viewController.refreshControl = refreshControlFake
                        viewController.collectionView = collectionViewFake
                    }

                    context("and is successful") {
                        beforeEach {
                            downloader.capturedCompletion?([StreamItem](), nil)
                        }
                        it("should reload collection view") {
                            expect(collectionViewFake.reloadDataCalled) == true
                        }
                        it("should stop refresh control") {
                            expect(refreshControlFake.endRefreshingCalled) == true
                        }
                    }
                    context("and failed") {
                        beforeEach {
                            let error = NSError(domain: "Foo", code: 123, userInfo: nil)
                            downloader.capturedCompletion?(nil, error)
                        }
                        it("should present error alert") {
                            //TODO
                        }
                        it("should stop refresh control") {
                            expect(refreshControlFake.endRefreshingCalled) == true
                        }
                    }
                }
            }

            describe("UICollectionViewDelegate") {
                beforeEach {

                }
                it("should present preview view controller when item is pressed") {
                    //TODO
                }
            }

            describe("UICollectionViewDataSource") {
                beforeEach {

                }
                it("should return number of item in section 0 equal to downloaded items") {
                    //TODO
                }
            }

            describe("righ bar button item") {
                var barButtonItem: UIBarButtonItem?
                beforeEach {
                    barButtonItem = viewController.navigationItem.rightBarButtonItem
                }
                it("should be set") {
                    expect(barButtonItem).notTo(beNil())
                }
                context("when pressed") {
                    beforeEach {
                        let action = barButtonItem!.action
                        viewController.performSelector(action, withObject: barButtonItem!)
                    }
                    it("should request item creation") {
                        expect(creator.createItemCalled) == true
                    }
                }
            }

            describe("ItemCreatingDelegate") {
                context("item was created") {
                    beforeEach {

                    }
                    it("should upload item") {
                        //TODO
                    }
                    context("when upload finished") {
                        context("with success") {
                            beforeEach {

                            }
                            it("should reload collection view") {
                                //TODO
                            }
                        }
                        context("with failure") {
                            beforeEach {

                            }
                            it("should present error alert") {
                                //TODO
                            }
                        }
                    }

                }
                context("failed to create item") {
                    beforeEach {

                    }
                    it("should present error alert") {
                        //TODO
                    }
                }
            }
        }
    }
}