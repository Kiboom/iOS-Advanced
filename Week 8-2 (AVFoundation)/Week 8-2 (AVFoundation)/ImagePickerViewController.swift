//
//  ImagePickerViewController.swift
//  Week 8-2 (AVFoundation)
//
//  Created by 김기범 on 2016. 8. 3..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit
import AssetsLibrary
import AVFoundation

private let reuseIdentifier = "photoCell"
private let cellSpacing:CGFloat = 2.0

class ImagePickerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    var assetsGroup: ALAssetsGroup?
    var assets: [ALAsset] = [ALAsset]()
    var chosenPhotos: [ALAsset] = [ALAsset]()
    let videoSettings = [
        AVVideoCodecKey: AVVideoCodecH264,
        AVVideoWidthKey: 640,
        AVVideoHeightKey: 480
    ]
    
    @IBOutlet var videofyButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        // Do any additional setup after loading the view.
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.allowsMultipleSelection = true
        
        self.videofyButton.enabled = false
        self.videofyButton.tintColor = UIColor.clearColor()
        
        self.activityIndicator.center = view.center
        self.view.addSubview(self.activityIndicator)
    }
    
    override func viewWillAppear(animated: Bool) {
        assets.removeAll()
        self.title = self.assetsGroup!.valueForProperty(ALAssetsGroupPropertyName).description
        
        chosenPhotos.removeAll()
        
        let assetsEnumerationBlock :ALAssetsGroupEnumerationResultsBlock = { (result: ALAsset!, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if (result != nil) {
                self.assets.append(result)
            }
        }
        self.assetsGroup!.setAssetsFilter(ALAssetsFilter.allPhotos())
        self.assetsGroup!.enumerateAssetsUsingBlock(assetsEnumerationBlock)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewSize = self.collectionView?.frame.size
        return CGSizeMake(collectionViewSize!.width/4-cellSpacing, collectionViewSize!.width/4-cellSpacing)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ImagePickerViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImagePickerViewCell
        cell.layer.borderColor = UIColor.clearColor().CGColor
        let asset:ALAsset = self.assets[indexPath.row]
        let thumbnail: UIImage = UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
        cell.imageView.image = thumbnail
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
     }
 
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.chosenPhotos.append(self.assets[indexPath.row])
        if self.chosenPhotos.count==1 {
            self.videofyButton.enabled = true
            self.videofyButton.tintColor = nil
        }
        let cell: UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        UIView.animateWithDuration(0.2,
                                   delay: 0,
                                   options: .AllowUserInteraction ,
                                   animations: {
                                    cell.layer.borderWidth = 3
                                    cell.layer.borderColor = UIColor(red:0.00, green:0.51, blue:0.95, alpha:1.00).CGColor
            },
                                   completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let index = self.chosenPhotos.indexOf(self.assets[indexPath.row])!
        self.chosenPhotos.removeAtIndex(index)
        if self.chosenPhotos.count==0 {
            self.videofyButton.enabled = false
            self.videofyButton.tintColor = UIColor.clearColor()
        }
        let cell: UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        UIView.animateWithDuration(0.2,
                                   delay: 0,
                                   options: .AllowUserInteraction ,
                                   animations: {
                                    cell.layer.borderWidth = 3
                                    cell.layer.borderColor = UIColor.clearColor().CGColor
            },
                                   completion: nil)
    }

    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    
    func writeImagesToMovieAtPath(path:String, withSize size:CGSize) {
        print("Write started!")
        
        do {
            try NSFileManager.defaultManager().removeItemAtPath(path)
        } catch {
            print(error)
        }
        
        var videoWriter: AVAssetWriter
        do {
            videoWriter = try AVAssetWriter.init(URL: NSURL.fileURLWithPath(path), fileType: AVFileTypeQuickTimeMovie)
        } catch {
            print(error)
            return
        }
        let videoSettings: NSDictionary = [AVVideoCodecH264 : AVVideoCodecKey,
                                           size.width : AVVideoWidthKey,
                                           size.height :AVVideoHeightKey]
        let videoWriterInput: AVAssetWriterInput = AVAssetWriterInput.init(mediaType: AVMediaTypeVideo, outputSettings: videoSettings as? [String : AnyObject])
        videoWriter.addInput(videoWriterInput)
        let adaptor: AVAssetWriterInputPixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor.init(assetWriterInput: videoWriterInput,
                                                                                                      sourcePixelBufferAttributes: nil)
        
        videoWriter.startWriting()
        videoWriter.startSessionAtSourceTime(kCMTimeZero)
        
        var frameCount: Int64 = 0
        for asset: ALAsset in self.chosenPhotos {
            let buffer: CVPixelBuffer = self.newPixelBufferFromAsset(asset)
            var appendOK: Bool = false
            var j = 0
            while appendOK==false && j<30 {
                if adaptor.assetWriterInput.readyForMoreMediaData {
                    print("appending \(frameCount) attemp \(j)")
                    let frameTime: CMTime = CMTimeMake(frameCount, 1 as __int32_t)
                    appendOK = adaptor.appendPixelBuffer(buffer, withPresentationTime: frameTime)
                    NSThread.sleepForTimeInterval(0.05)
                }
                else {
                    print("adaptor not ready \(frameCount), \(j)")
                    NSThread.sleepForTimeInterval(0.1)
                }
                j += 1
            }
            if appendOK == false {
                print("error appending image \(frameCount) times \(j)")
            }
            frameCount += 1
        }
        
        videoWriterInput.markAsFinished()
        videoWriter.finishWritingWithCompletionHandler { 
            print("The Merging Is Complete!")
            self.saveToCameraRoll(NSURL.init(fileURLWithPath: path))
        }
    }
    
    
    func newPixelBufferFromAsset(asset: ALAsset) -> CVPixelBufferRef {
        let imageRef: CGImageRef = CGImageCreateCopy(asset.defaultRepresentation().fullResolutionImage().takeUnretainedValue())!
        let uiImage: UIImage = UIImage.init(CGImage: imageRef)
        let frameSize: CGSize = uiImage.size
        
        let options: NSDictionary = NSDictionary.init(dictionary: [kCVPixelBufferCGImageCompatibilityKey : true,
                                   kCVPixelBufferCGBitmapContextCompatibilityKey : true])
        var pixelBuffer: CVPixelBuffer?
        let status: CVReturn = CVPixelBufferCreate(kCFAllocatorDefault,
                                                   Int(frameSize.width),
                                                   Int(frameSize.height),
                                                   kCVPixelFormatType_32ARGB,
                                                   options as CFDictionaryRef,
                                                   &pixelBuffer)
        
        assert(status == kCVReturnSuccess && pixelBuffer != nil)
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, 0)
        let pixelData: UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let context: CGContextRef = CGBitmapContextCreate(pixelData,
                                                          Int(frameSize.width),
                                                          Int(frameSize.height),
                                                          8,
                                                          4*Int(frameSize.width),
                                                          rgbColorSpace,
                                                          CGImageAlphaInfo.NoneSkipFirst.rawValue)!
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(0))
        CGContextDrawImage(context,
                           CGRectMake(0 + (frameSize.width - CGFloat(CGImageGetWidth(imageRef)))/2,
                            (frameSize.height - CGFloat(CGImageGetHeight(imageRef)))/2,
                            CGFloat(CGImageGetWidth(imageRef)),
                            CGFloat(CGImageGetHeight(imageRef))),
                           imageRef)
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, 0)
        
        return pixelBuffer!
    }
    
    
    func saveToCameraRoll(path: NSURL) {
        let library: ALAssetsLibrary = ALAssetsLibrary()
        if library.videoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
            library.writeVideoAtPathToSavedPhotosAlbum(path, completionBlock: { (newURL, error) in
                if error != nil {
                    print("Photo Library에 저장 중 오류 발생! : \(error)")
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertController = UIAlertController(title: "Video Created!", message: "Check out your Photo Library!", preferredStyle: UIAlertControllerStyle.Alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default ) { (result : UIAlertAction) -> Void in
                            print("OK")
                        }
                        alertController.addAction(okAction)
                        self.presentViewController(alertController, animated: true, completion: {
                            self.activityIndicator.stopAnimating()
                        })
                    });
                    print("Video Saved!")
                }
            })
        }
    }
    
    @IBAction func videofy(sender: AnyObject) {
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        let documentsDirectoryPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let savePath: String = "\(documentsDirectoryPath)/c.mov"
//        UISaveVideoAtPathToSavedPhotosAlbum (exportVideoPath,self, @selector(video:didFinishSavingWithError: contextInfo:), nil);
        self.writeImagesToMovieAtPath(savePath, withSize: CGSizeMake(640.0, 480.0))
    }
    
}
