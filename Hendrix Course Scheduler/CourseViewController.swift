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
    }
    
    func refresh_course() {
        loadCourses()
    }
    
    func dataLoaded(notification : NSNotification){
        if (self.refreshControl == nil){
            self.refreshControl = UIRefreshControl()
            self.refreshControl!.backgroundColor = UIColor.whiteColor()
            self.refreshControl!.tintColor = UIColor.orangeColor()
            self.refreshControl!.addTarget(self, action: "refresh_course", forControlEvents: UIControlEvents.ValueChanged)
        }
        courses_display = []
        var results = Course.allWithOrder("title ASC")
        for course in results{
            courses_display.append(course as Course)
        }
        self.refreshControl!.endRefreshing()
        self.tableView.reloadData()
        parent.update_from_last()
        
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
            var code = course.courseCode
            var course_string = code.substringToIndex(advance(code.startIndex, countElements(code) - 4)).substringFromIndex(advance(code.startIndex, 5))
            cell.courseTitle.text = "\(course.title) - \(course_string)"
            cell.department.text = course.subjectCode.name
            cell.instructor.text = course.instructor.name
        }
        else {
            cell.courseTitle.text = "You shouldn't be seeing this"
            println("Caught a nil... Probably should look at it.\n")
        }
        return cell
    }
    
    func add_course_to_schedule(course: Course){
        if let sched = current_schedule? {
            sched.courses = sched.courses.setByAddingObject(course)
            sched.save()
        }
        update_schedule()
    }
    
    func update_courses(courses: Array<Course>){
        self.courses_display = courses
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var (pop, course) = CourseDetailsControllerPopover()
        course.course = courses_display[indexPath.row]
        course.courseViewController = self
        pop.presentPopoverFromRect(CGRectZero, inView: tableView.cellForRowAtIndexPath(indexPath)!, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        
    }
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
