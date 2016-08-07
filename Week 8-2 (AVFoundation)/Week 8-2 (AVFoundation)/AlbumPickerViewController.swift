//
//  AlbumPickerViewController.swift
//  Week 8-2 (AVFoundation)
//
//  Created by 김기범 on 2016. 8. 3..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit
import AssetsLibrary

class AlbumPickerViewController: UITableViewController {
    
    let assetsLibrary: ALAssetsLibrary = ALAssetsLibrary()
    var groups: [ALAssetsGroup] = [ALAssetsGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let groupTypes:UInt32 = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos
        assetsLibrary.enumerateGroupsWithTypes(groupTypes,
                                               usingBlock: {
                                                (group: ALAssetsGroup!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                                                if group == nil {
                                                    return
                                                }
                                                if group.numberOfAssets() > 0 {
                                                    self.groups.append(group)
                                                } else {
                                                    self.tableView.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: false)                                                                                                        }
            },
                                               failureBlock: {
                                                (myerror: NSError!) -> Void in
                                                print("error occurred: \(myerror.localizedDescription)")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let groupForCell: ALAssetsGroup = self.groups[indexPath.row]
        let posterImageRef: CGImageRef = groupForCell.posterImage().takeUnretainedValue()
        let posterImage: UIImage = UIImage.init(CGImage:posterImageRef)
        cell.imageView!.image = posterImage
        cell.textLabel!.text = groupForCell.valueForProperty(ALAssetsGroupPropertyName) as? String
        cell.detailTextLabel!.text = groupForCell.numberOfAssets().description
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImagePicker" {
            let selectedIndexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
            if self.groups.count > selectedIndexPath.row {
                let imagePickerViewController: ImagePickerViewController = segue.destinationViewController as! ImagePickerViewController
                imagePickerViewController.assetsGroup = self.groups[selectedIndexPath.row]
            }
        }
     }
    
}
