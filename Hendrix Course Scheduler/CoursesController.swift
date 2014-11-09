//
//  ViewController.swift
//  Hendrix Course Scheduler
//
//  Created by John McAvey on 11/4/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import UIKit

class CoursesController: UIViewController {
    
    var left_view : CoursesFilterView
    var right_view : CourseViewController
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
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screen_height = screenSize.height
        let screen_width = screenSize.width
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        var left_controller = UINavigationController()
        var right_controller = UINavigationController()
        
        left_controller.view.frame = CGRectMake(5, 20, 320, screen_height - 25)
        right_controller.view.frame = CGRectMake(330, 20, screen_width - 335, screen_height - 25)
        
        left_controller.setViewControllers([left_view], animated: false)
        right_controller.setViewControllers([right_view], animated: false)
        
        left_controller.view.layer.cornerRadius = 5
        left_controller.view.layer.masksToBounds = true
        
        right_controller.view.layer.cornerRadius = 5
        right_controller.view.layer.masksToBounds = true
        
        self.view.addSubview(left_controller.view)
        self.view.addSubview(right_controller.view)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update_with_filter(criteria: String){
        //filter
    }
    
    func add_course(course: AnyObject){
        courses.append(course)
        //send message to left controller
    }
}

