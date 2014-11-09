//
//  ViewController.swift
//  Hendrix Course Scheduler
//
//  Created by John McAvey on 11/4/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import UIKit

class CoursesController: UIViewController {
    var left_view : UIView;
    var right_view : UIView;

    required init(coder aDecoder: NSCoder) {
        left_view = UIView();
        right_view = UIView();
        super.init();
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

