//
//  CoursesFilterView.swift
//  Hendrix Course Scheduler
//
//  Created by John McAvey on 11/8/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import UIKit

class CoursesFilterView: UITableViewController {
    var courses : Array<Course>!
    var criteria: Dictionary<String, Array<String>>!
    var criteria_keys : Array<String>!
    var parent: CoursesController!
    
    var showFullCourses = true
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filters"
        courses = []
        criteria = Dictionary<String, Array<String>>()
        criteria["Instructor"] = ["All"]
        criteria["Department"] = ["All"]
        criteria_keys = []
        for key in criteria.keys {
            criteria_keys.append(key)
        }
        criteria_keys.sort { $0 < $1 }
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        self.view.layer.borderColor = UIColor.blackColor().CGColor
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.1
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dataFinishedLoading:", name: "DataFinishedLoading", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update_schedule", name: "RefreshSchedule", object: nil)
        
        self.update_schedule()
    }
    
    func update_schedule() {
        if let sched = current_schedule? {
            courses = []
            if sched.courses.count > 0 {
                for course in sched.courses {
                    var crs = course as Course
                    courses.append(crs)
                }
            }
        }
        courses.sort({ (course1: Course, course2: Course) -> Bool in
            return course1.title < course2.title
        })
        self.tableView.reloadData()
    }
    
    func dataFinishedLoading(notification : NSNotification){
        var instructors = Instructor.allWithOrder("name ASC")
        var tempArray : Array<String> = ["All"]
        for ins in instructors{
            tempArray.append((ins as Instructor).name)
        }
        criteria["Instructor"] = tempArray
        
        var departments = SubjectCode.allWithOrder("name ASC")
        tempArray = ["All"]
        for ins in departments{
            tempArray.append((ins as SubjectCode).name)
        }
        criteria["Department"] = tempArray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return criteria_keys.count+1
        }
        else if section == 1 {
            return courses.count > 0 ? courses.count : 1
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        if indexPath.section == 0 {
            if indexPath.row == 2 {
                cell.textLabel!.text = "Show Full Courses"
                var enabledSwitch = UISwitch(frame: CGRectMake(0, 0, 75, 30)) as UISwitch
                enabledSwitch.on = true
                cell.accessoryView = enabledSwitch
                enabledSwitch.addTarget(self, action: "switchValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
            } else {

            var title = criteria_keys[indexPath.row]
            var options = criteria[title]!
            var value = options[0]
            cell.textLabel!.text = "\(title): \(value)"
            }
        }
        else if indexPath.section == 1 {
            var title = ""
            if indexPath.row < courses!.count {
                title = courses[indexPath.row].title
            }
            else {
                title = "No Courses"
            }
            cell.textLabel!.text = title
            cell.accessoryView = nil
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["Filter Criteria", "Selected Courses", ""][section]
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
            var crs = courses[indexPath.row]
            courses!.removeAtIndex(indexPath.row)
            current_schedule.removeCoursesObject(crs)
            current_schedule.save()
            self.tableView.reloadData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row < 2 {
            let option_selector = OptionSelectorView()
            let options = criteria[criteria_keys[indexPath.row]]!
            option_selector.setOptions(self, options: options)
            self.navigationController?.pushViewController(option_selector, animated: true)
        }
        else {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func set_new_value(label: String){
        let cell = self.tableView.cellForRowAtIndexPath(self.tableView.indexPathForSelectedRow()!)!
        let key_str = cell.textLabel!.text?.componentsSeparatedByString(":")[0]
        cell.textLabel!.text = key_str! + ": " + label
        self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: true)
        self.navigationController?.popToRootViewControllerAnimated(true)
        parent.update_with_filter(get_filter_parameters())
    }
    
    func get_filter_parameters() -> Dictionary<String, String>{
        var params = Dictionary<String, String>()
        for i in 0..<2{
            let idxPath = NSIndexPath(forRow: i, inSection: 0)
            let cell = self.tableView.cellForRowAtIndexPath(idxPath)!
            let key = cell.textLabel!.text?.componentsSeparatedByString(":")[0]
            let value = cell.textLabel!.text?.componentsSeparatedByString(":")[1]
            params[key!] = value!
        }
        
        return params
    }
    
    func switchValueChanged (sender: UISwitch) {
        showFullCourses = sender.on
        parent.update_with_filter(get_filter_parameters())
        println("Show full courses: \(showFullCourses)")
    }
    
    func toShowFullCourses() -> Bool {
        return showFullCourses
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
