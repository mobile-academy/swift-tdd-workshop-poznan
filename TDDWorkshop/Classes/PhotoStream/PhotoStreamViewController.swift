//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UICollectionViewController, StreamItemCreatorDelegate {

    let parseAdapter = ParseAdapter() //TODO refactor
    
    var downloader: StreamItemDownloader?
    var creator: StreamItemCreator?
    var uploader: StreamItemUploader?
    var imageManipulator: ImageManipulator?
    var presenter: ViewControllerPresenter?
    var refreshControl: UIRefreshControl?

    var streamItems = [StreamItem]()

    //MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DefaultViewControllerPresenter(viewController: self)
        imageManipulator = DefaultImageManipulator()
        
        downloader = StreamItemDownloader(parseAdapter: parseAdapter)
        creator = StreamItemCreator(presenter: presenter!)
        uploader = StreamItemUploader(parseAdapter: parseAdapter)
        
        creator?.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "didPullToRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView?.addSubview(refreshControl!)
        
        collectionView?.alwaysBounceVertical = true
        
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
            photoCell.imageView.image = imageManipulator?.imageFromData(streamItem.imageData)
        }
        return cell
    }
    
    //MARK: Actions
    
    @IBAction func didPressAddItemBarButtonItem(sender: UIBarButtonItem!) {
        creator?.createStreamItem()
    }
    
    func didPullToRefresh(refreshControl: UIRefreshControl) {
        downloadStreamItems()
    }
    
    //MARK: StreamItemCreatorDelegate

    func creator(creator: StreamItemCreator, didCreateItem item: StreamItem) {
        uploader?.uploadItem(item) {success, error in
            if success == false {
                NSLog("Failed to upload: \(error)")
            } else {
                NSLog("Uploaded item!")
            }
        }
    }

    func creator(creator: StreamItemCreator, failedWithError: ErrorType) {
    }

    //MARK: Private methods
    
    
    private func downloadStreamItems() {
        downloader?.downloadItems {[weak self] items, error in
            
            self?.refreshControl?.endRefreshing()
            
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



