//
//  CoursesFilterView.swift
//  Hendrix Course Scheduler
//
//  Created by John McAvey on 11/8/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import UIKit

class CoursesFilterView: UITableViewController {
    var courses : Array<AnyObject>?
    var criteria: Dictionary<String, Array<String>>?
    var criteria_keys : Array<String>?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Courses View"
        courses = []
        criteria = Dictionary<String, Array<String>>()
        criteria_keys = criteria?.keys.array
        criteria_keys?.sort { $0 < $1 }
        
        self.view.layer.borderColor = UIColor.blackColor().CGColor
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return criteria_keys!.count
        }
        else if section == 1 {
            var count: Int = courses!.count
            return count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        if indexPath.section == 0 {
            var title = criteria_keys![indexPath.row]
            var init_key : String = criteria_keys![0]
            var result = criteria![init_key]
            cell.textLabel.text = String(format: "%s : %s", title, result!)
        }
        if indexPath.section == 1 {
            var title = ""
            if indexPath.section < courses!.count {
                title = courses![indexPath.section] as String
            }
            else{
                title = "No Course"
            }
            cell.textLabel.text = title
        }

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Allow editing of the courses, but not the filters.  Section 1.
        return indexPath.section == 1 && indexPath.row < courses!.count
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            courses!.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
