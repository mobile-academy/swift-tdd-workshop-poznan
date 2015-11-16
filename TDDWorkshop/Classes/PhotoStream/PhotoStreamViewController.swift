//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UICollectionViewController, ItemCreatingDelegate {

    var parseAdapter: ParseAdapting
    
    var downloader: ItemDownloading
    var creator: ItemCreating
    var uploader: ItemUploading

    var imageManipulator: ImageManipulating
    var presenter: ViewControllerPresenting
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

        super.init(coder: coder)
        presenter.viewController = self
        creator.delegate = self
    }

    //MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    //MARK: ItemCreatingDelegate

    func creator(creator: ItemCreating, didCreateItem item: StreamItem) {
        uploader.uploadItem(item) {success, error in
            if success == false {
                NSLog("Failed to upload: \(error)")
            } else {
                NSLog("Uploaded item!")
            }
        }
    }

    func creator(creator: ItemCreating, failedWithError: ErrorType) {
    }

    //MARK: Private methods

    private func setupCollectionView() {
        refreshControl.addTarget(self, action: "didPullToRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView?.addSubview(refreshControl)
        collectionView?.alwaysBounceVertical = true
    }

    private func downloadStreamItems() {
        downloader.downloadItems {[weak self] items, error in
            self?.refreshControl.endRefreshing()
            if error != nil {
                //TODO prompt about error
            } else {
                if items != nil {
                    self?.streamItems = items!
                } else {
                    self?.streamItems = [] //TODO improve this
                }
                self?.collectionView?.reloadData()
            }
        }
    }

}



