//
//  KKBTableViewController.swift
//  Week 7-1 (Realm.io)
//
//  Created by 김기범 on 2016. 7. 27..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit
import RealmSwift

class KKBTableViewController: UITableViewController {

    let realm = try! Realm()
    var people: Results<KKBPerson>?
    var personToEdit: KKBPerson?
//    var tableViewController: KKBTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.people = realm.objects(KKBPerson.self)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((self.people) != nil) {
            return (self.people?.count)!
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:KKBTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! KKBTableViewCell
        cell.title.text = people![indexPath.row].name
        cell.subTitle.text = String(people![indexPath.row].age)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let person = self.people![indexPath.row]
            try! realm.write {
                realm.delete(person)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.people = realm.objects(KKBPerson.self)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.personToEdit = self.people![indexPath.row]
        print("\(self.personToEdit!.name), \(self.personToEdit!.age)")
        return indexPath
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationViewController = segue.destinationViewController as! UINavigationController
        let tableViewController = navigationViewController.visibleViewController as! KKBPersonViewController
        tableViewController.personToEdit = self.personToEdit
        self.personToEdit = nil
    }

}
