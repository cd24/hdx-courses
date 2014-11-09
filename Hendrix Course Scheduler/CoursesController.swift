//
//  ViewController.swift
//  Hendrix Course Scheduler
//
//  Created by John McAvey on 11/4/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var left_view : CoursesFilterView
    var right_view : CourseViewController
    var courses : Array<AnyObject>
   
    required init(coder aDecoder: NSCoder) {
        left_view = CoursesFilterView()
        right_view = CourseViewController()
        courses = Array<AnyObject>()
        super.init()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
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

