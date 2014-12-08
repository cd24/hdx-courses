//
//  OptionSelectorView.swift
//  Hendrix Course Scheduler
//
//  Created by John McAvey on 11/9/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import UIKit

class OptionSelectorView: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var options : Array<String>!
    var filter_options: Array<String>!
    var selected : String!
    var parent : CoursesFilterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var search_bar = UISearchBar()
        
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    
    func setOptions(parent: CoursesFilterView, options: Array<String>){
        self.options = options
        self.parent = parent
        self.filter_options = []
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
        if false{// tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filter_options.count
        } else {
            return options.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        
        if false{//tableView == self.searchDisplayController!.searchResultsTableView {
            cell.textLabel!.text = filter_options[indexPath.row]
        }
        else {
            cell.textLabel!.text = options[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected = options[indexPath.row]
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = self.tableView!.cellForRowAtIndexPath(indexPath)
        let label = cell?.textLabel!.text
        parent.set_new_value(label!)
    }
    
    func filterContentForSearchText(searchText: String){
        self.filter_options = self.options.filter({ (String str) -> Bool in
            let string_match = str.rangeOfString(searchText)
            return string_match != nil
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
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
