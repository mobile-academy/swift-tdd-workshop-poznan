//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol StreamItemCreatorDelegate: class {
    func creator(creator: StreamItemCreator, didCreateItem item: StreamItem)
    func creator(creator: StreamItemCreator, failedWithError: ErrorType)
}

class StreamItemCreator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties

    weak var delegate: StreamItemCreatorDelegate?

    var controllerPresenter: ViewControllerPresenter
    var resourceAvailability: ResourceTypeAvailability
    var actionFactory: AlertActionFactory
    var pickerFactory: ImagePickerFactory
    var imageManipulator: ImageManipulator

    //MARK: Object Life Cycle

    init(presenter: ViewControllerPresenter) {
        controllerPresenter = presenter
        resourceAvailability = ResourceTypeAvailability()
        actionFactory = DefaultAlertActionFactory()
        pickerFactory = DefaultImagePickerFactory()
        imageManipulator = DefaultImageManipulator()
    }

    //MARK: Public methods

    func createStreamItem() {
        presentAlertController()
        //TODO
    }

    //MARK: UIImagePickerControllerDelegate

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let scaledImage = imageManipulator.scaleImage(image, width: 300)
            let imageData = imageManipulator.dataFromImage(scaledImage, quality: 0.7)
            let streamItem = StreamItem(title: "Foo Bar", imageData: imageData)
            delegate?.creator(self, didCreateItem: streamItem)
            controllerPresenter.dismissViewController(picker) //TODO test me!
        } else {
            //TODO
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        controllerPresenter.dismissViewController(picker)
    }

    //MARK: Private methods

    private func presentAlertController() {
        let alertController = UIAlertController(title: "Add new Item to the stream", message: nil, preferredStyle: .ActionSheet)

        if resourceAvailability.photoLibraryAvailable() {
            let alertAction = actionFactory.createActionWithTitle("Pick from Library", style: .Default) {[weak self] action in
                self?.presentPickerWithResourceType(.PhotoLibrary)
            }
            alertController.addAction(alertAction)
        }
        if resourceAvailability.cameraAvailable() {
            let alertAction = actionFactory.createActionWithTitle("Take a Photo", style: .Default) {[weak self] action in
                self?.presentPickerWithResourceType(.Camera)
            }
            alertController.addAction(alertAction)
        }
        let cancelAction = actionFactory.createActionWithTitle("Cancel", style: .Cancel) {action in
        }
        alertController.addAction(cancelAction)
        controllerPresenter.presentViewController(alertController)
    }

    private func presentPickerWithResourceType(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = pickerFactory.createPickerWithSourceType(sourceType)
        imagePicker.delegate = self
        controllerPresenter.presentViewController(imagePicker)
    }

}
