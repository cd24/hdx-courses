//
//  NetworkRequests.swift
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 11/8/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import Foundation

func loadCourses(){
    Course.deleteAll()
    var op = AFHTTPRequestOperationManager()
    op.requestSerializer = AFHTTPRequestSerializer() as AFHTTPRequestSerializer
    op.requestSerializer.setValue("application/atomsvc+xml;q=0.8, application/json;odata=fullmetadata;q=0.7, application/json;q=0.5, */*;q=0.1", forHTTPHeaderField: "Accept")
    op.GET("http://hoike.hendrix.edu/odata/Courses?$filter=Year%20eq%20%272014%27&$orderby=CourseCode&$skip=0&$top=1074&$inlinecount=allpages", parameters: nil, success: { (op: AFHTTPRequestOperation!, res: AnyObject!) -> Void in
        var dict = res as NSDictionary
        if let courses = dict["value"] as? NSArray {
            for c in courses{
                if let c = c as? NSDictionary{
                    var course = Course.create() as Course
                    if let title = c["Title"] as? String{
                        course.title = title
                    }
                    if let building = c["Building"] as? String{
                        course.building = building
                    }
                    course.save()
                }
            }
        }
        var res = Course.all()
        for c in res{
            var course = c as Course
            print(course.title)
            print(": \(course.building)")
        }
        }) { (op: AFHTTPRequestOperation!, error:NSError!) -> Void in
        print(error)
    }
}