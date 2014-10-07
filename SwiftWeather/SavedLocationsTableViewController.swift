//
//  SavedLocationsTableViewController.swift
//  SwiftWeather
//
//  Created by Marshall Upshur on 10/6/14.
//  Copyright (c) 2014 Marshall Upshur. All rights reserved.
//

import UIKit

class SavedLocationsTableViewController: UITableViewController {
    
    // a property
    var savedLocations = [String]()
    var tempLocation: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        savedLocations = ["Chicago", "Atlanta", "Portland"]
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "savedLocationsBackground"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return savedLocations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("savedLocationCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = savedLocations[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        var cellBackground =  UIColor.whiteColor().colorWithAlphaComponent(0.08)
        
        cell.backgroundColor = cellBackground
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = UIColor.clearColor()
        }
    }
    
    @IBAction func didPressSavedLocation(sender: AnyObject) {
        // the ! here is telling the compiler that this optional value might not have a value, but its okay at this point
        // TODO: find a better explanation of this
        if !contains(savedLocations, tempLocation!) {
            savedLocations.insert(tempLocation!, atIndex: 0)
            println(savedLocations)
        } else {
            var alert = UIAlertController(title: "Duplicate Location", message: "That location is already saved.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        self.tableView.reloadData()
    }
    
    
    // TODO: come back to this to explore further!

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
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
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
