//
//  CourseViewController.swift
//  Hendrix Course Scheduler
//
//  Created by John McAvey on 11/8/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import UIKit

class CourseViewController: UITableViewController {
    
    var parent: CoursesController!
    var courses_display: Array<Course>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courses_display = []
        
        self.title = "Courses"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Calendar", style: UIBarButtonItemStyle.Plain, target: self, action: "calendar")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Schedule", style: UIBarButtonItemStyle.Plain, target: self, action: "schedule:")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dataLoaded:", name: "DataFinishedLoading", object: nil)
        self.tableView.registerNib(UINib(nibName: "CourseCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = 62.0
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refresh_course() {
        loadCourses()
    }
    
    func dataLoaded(notification : NSNotification){
        if (self.refreshControl == nil){
            self.refreshControl = UIRefreshControl()
            self.refreshControl!.backgroundColor = UIColor.orangeColor()
            self.refreshControl!.tintColor = UIColor.whiteColor()
            self.refreshControl!.addTarget(self, action: "refresh_course", forControlEvents: UIControlEvents.ValueChanged)
        }
        courses_display = []
        var results = Course.allWithOrder("title ASC")
        for course in results{
            courses_display.append(course as Course)
        }
        self.refreshControl!.endRefreshing()
        self.tableView.reloadData()
        
    }
    func schedule(sender : UIBarButtonItem!){
        var story = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var vc = story.instantiateViewControllerWithIdentifier("scheduleChange") as UIViewController
        var pop = UIPopoverController(contentViewController: vc)
        pop.presentPopoverFromBarButtonItem(sender, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
    }
    func calendar(){
        (self.navigationController?.parentViewController as CoursesController).switchCalendar()
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
        return courses_display.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CourseCell

        // Configure the cell...
        var course = courses_display[indexPath.row]
        
        if (course.title != nil && course.subjectCode.name != nil && course.instructor.name != nil) {
            cell.courseTitle.text = course.title
            cell.department.text = course.subjectCode.name
            cell.instructor.text = course.instructor.name
        }
        else {
            cell.courseTitle.text = "You shouldn't be seeing this"
            cell.backgroundColor = UIColor.redColor()
            println("Caught a nil... Probably should look at it.\n")
        }
        return cell
    }
    
    func update_courses(courses: Array<Course>){
        self.courses_display = courses
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
class CourseCell : UITableViewCell {
    @IBOutlet var courseTitle : UILabel!
    @IBOutlet var department : UILabel!
    @IBOutlet var instructor : UILabel!
    @IBOutlet var days : UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
