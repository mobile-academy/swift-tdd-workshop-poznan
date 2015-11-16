//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class PhotoStreamLayout: UICollectionViewFlowLayout {

    //MARK: Object Life Cycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sectionInset = UIEdgeInsets(top:8.0, left: 0.0, bottom:8.0, right:0.0)
        minimumInteritemSpacing = 4.0
        minimumLineSpacing = 4.0
        itemSize = CGSize(width: 77.0, height: 77.0)
    }
}
