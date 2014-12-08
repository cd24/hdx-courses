//
//  CourseDetailsController.swift
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 12/7/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import Foundation
func CourseDetailsControllerPopover() -> (UIPopoverController,CourseDetailsController){
    
    var nav = UINavigationController()
    var course = CourseDetailsController(style: UITableViewStyle.Grouped)
    nav.setViewControllers([course], animated: true)
    
    var pop = UIPopoverController(contentViewController: nav)
    return (pop,course)
}
class LightWrapper : UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class CourseDetailsController : UITableViewController{
    var course : Course!
    var courseViewController : CourseViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(LightWrapper.classForCoder(), forCellReuseIdentifier: "Cell")
        self.navigationItem.title = "Course Details"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        if indexPath.section == 0{
            cell.textLabel!.text = "Add Course"
            cell.textLabel!.textAlignment = NSTextAlignment.Center
        }
        else if indexPath.section == 1 && course != nil{
            cell.textLabel!.textAlignment = NSTextAlignment.Left
            switch indexPath.row{
            case 0:
                cell.textLabel?.text = "Title:"
                cell.detailTextLabel?.text = course.title
            case 1:
                cell.textLabel?.text = "Professor:"
                cell.detailTextLabel?.text = course.instructor.name
            case 2:
                cell.textLabel?.text = "Term:"
                cell.detailTextLabel?.text = course.term
            case 3:
                cell.textLabel?.text = "Time:"
                var res = ClassPeriodsShared.DisplayStrings
                print(course.period)
                if course.period != nil && res[course.period] != nil{
                    cell.detailTextLabel?.text = res[course.period]
                }
            case 4:
                cell.textLabel?.text = "Enrollment:"
                cell.detailTextLabel?.text = "\(course.currentEnrollment)/\(course.capacity)"
            case 5:
                cell.textLabel?.text = "Building:"
                cell.detailTextLabel?.text = course.building
            default:
                break
            }
        }
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 6
        }
        return 0
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0{
            courseViewController.add_course_to_schedule(course)
        }
    }
    
}