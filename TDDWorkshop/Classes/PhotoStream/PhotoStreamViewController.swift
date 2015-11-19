//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UICollectionViewController, ItemCreatingDelegate {

    //MARK: Properties

    var parseAdapter: ParseAdapting
    var downloader: ItemDownloading
    var creator: ItemCreating
    var uploader: ItemUploading
    var imageManipulator: ImageManipulating
    var presenter: ViewControllerPresenting
    var alertActionFactory: AlertActionCreating
    var refreshControl: UIRefreshControl

    var streamItems = [StreamItem]()

    //MARK: Object Life Cycle

    required init?(coder: NSCoder) {
        parseAdapter = DefaultParseAdapter()
        presenter = DefaultViewControllerPresenter()
        imageManipulator = DefaultImageManipulator()
        refreshControl = UIRefreshControl()
        downloader = StreamItemDownloader(parseAdapter: parseAdapter)
        creator = StreamItemCreator(presenter: presenter)
        uploader = StreamItemUploader(parseAdapter: parseAdapter)
        alertActionFactory = DefaultAlertActionFactory()

        super.init(coder: coder)
        presenter.viewController = self
        creator.delegate = self
    }

    //MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        downloadStreamItems()
    }

    //MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamItems.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoStreamCell", forIndexPath: indexPath)
        if let photoCell = cell as? PhotoStreamCell {
            let streamItem = streamItems[indexPath.row]
            photoCell.imageView.layer.borderColor = UIColor.redColor().CGColor
            photoCell.imageView.layer.borderWidth = 1.0
            photoCell.imageView.contentMode = UIViewContentMode.ScaleAspectFill
            photoCell.imageView.image = imageManipulator.imageFromData(streamItem.imageData)
        }
        return cell
    }
    
    //MARK: Actions
    
    @IBAction func didPressAddItemBarButtonItem(sender: UIBarButtonItem!) {
        creator.createStreamItem()
    }
    
    func didPullToRefresh(refreshControl: UIRefreshControl) {
        downloadStreamItems()
    }

    //TODO: Task 2
    //TODO: To setup presented view controller override `prepareForSegue` method
    //TODO: Segue ID is "StreamItemPrevieSegue"
    //TODO: Get selected index path by quering `UICollectionView` with `indexPathsForSelectedItems` method
    //TODO: Get selected `StreamItem` pass it to `destinationViewController` of `segue`

    //TODO: Uncomment for Task 2
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    */
    
    //MARK: ItemCreatingDelegate

    func creator(creator: ItemCreating, didCreateItem item: StreamItem) {
        uploader.uploadItem(item) {[weak self] success, error in
            if success == false {
                self?.presentErrorAlertWithMessage("Failed to upload stream item!")
            } else {
                // TODO: Task 1
                // TODO: add `item` to `streamItems`
                // TODO: reload data on `collectionView`
            }
        }
    }

    func creator(creator: ItemCreating, failedWithError: ErrorType) {
        presentErrorAlertWithMessage("Failed to create stream item!")
    }

    //MARK: Private methods

    private func presentErrorAlertWithMessage(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        errorAlert.addAction(alertActionFactory.createActionWithTitle("Cancel", style: .Cancel) {action in })
        presenter.presentViewController(errorAlert)
    }

    private func setupCollectionView() {
        refreshControl.addTarget(self, action: "didPullToRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView?.addSubview(refreshControl)
        collectionView?.alwaysBounceVertical = true
    }

    private func downloadStreamItems() {
        downloader.downloadItems {[weak self] items, error in
            self?.refreshControl.endRefreshing()
            if error != nil || items == nil {
                self?.presentErrorAlertWithMessage("Failed to download stream items!")
            } else {
                self?.streamItems = items!
                self?.collectionView?.reloadData()
            }
        }
    }
}



