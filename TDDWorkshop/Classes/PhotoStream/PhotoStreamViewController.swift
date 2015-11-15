//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UICollectionViewController {

    let parseAdapter = ParseAdapter()

    var downloader: StreamItemDownloader?
    var creator: StreamItemCreator?
    var uploader: StreamItemUploader?

    //MARK: Object Life Cycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }

    convenience init() {
        self.init(collectionViewLayout: PhotoStreamLayout())
    }

    //MARK: View Life Cycle


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.registerClass(PhotoStreamCell.self, forCellWithReuseIdentifier: "CellId")



    }
}



