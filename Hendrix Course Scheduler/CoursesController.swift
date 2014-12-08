//
//  ViewController.swift
//  Hendrix Course Scheduler
//
//  Created by John McAvey on 11/4/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import UIKit

class CoursesController: UIViewController {
    
    var left_view : CoursesFilterView!
    var right_view : CourseViewController!
    var courses : Array<AnyObject>
   
    override init() {
        left_view = CoursesFilterView(style: UITableViewStyle.Grouped)
        right_view = CourseViewController(style: UITableViewStyle.Grouped)
        courses = Array<AnyObject>()
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        left_view = CoursesFilterView(style:UITableViewStyle.Grouped)
        right_view = CourseViewController(style: UITableViewStyle.Grouped)
        courses = Array<AnyObject>()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var schedules = Schedule.all()
        if schedules.count > 0 {
            current_schedule = schedules[0] as Schedule
        }
        
        left_view.parent = self
        right_view.parent = self
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screen_height = screenSize.height
        let screen_width = screenSize.width
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        var left_controller = UINavigationController(rootViewController: left_view)
        var right_controller = UINavigationController(rootViewController: right_view)
        
        left_controller.view.frame = CGRectMake(5, 20, 320, screen_height - 25)
        right_controller.view.frame = CGRectMake(330, 20, screen_width - 335, screen_height - 25)
        
        left_controller.view.layer.cornerRadius = 5
        left_controller.view.layer.masksToBounds = true
        
        right_controller.view.layer.cornerRadius = 5
        right_controller.view.layer.masksToBounds = true
        self.addChildViewController(left_controller)
        self.addChildViewController(right_controller)
        self.view.addSubview(left_controller.view)
        self.view.addSubview(right_controller.view)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func switchCalendar(){
        self.performSegueWithIdentifier("calendar", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update_with_filter(parameters: Dictionary<String, String>){
        //filter
        var courses = Array<Course>()
        let keys = parameters.keys.array
        var filter_string = get_filter_string(parameters, value: keys[0])
        for i in 1..<keys.count {
            let next_append = get_filter_string(parameters, value: keys[i])
            if countElements(next_append) > 0 && countElements(filter_string) > 0{
                filter_string += " AND "
            }
            filter_string += next_append
        }
        println(filter_string)
        if countElements(filter_string) == 0 {
            courses = Course.allWithOrder("title") as Array<Course>
        }
        else{
            courses = Course.whereT(filter_string, order: "title") as Array<Course>
        }
        /*
        TODO: Apply filter criteria to data model
        */
        
        right_view.update_courses(courses)
    }
    
    func get_filter_string(dict: Dictionary<String, String>, value: String) -> String{
        var string = ""
        if (dict[value]!.rangeOfString("All") != nil){
            return ""
        }
        else if value == "Department"{
            let val = dict[value]!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            return "subjectCode.name LIKE '\(val)'"
        }
        else{
            let val = dict[value]!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            return "\(value.lowercaseString).name LIKE '\(val)'"
        }
    }
    
    func add_course(course: AnyObject){
        courses.append(course)
        //send message to left controller
    }
}

