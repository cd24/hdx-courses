//
//  NetworkRequests.swift
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 11/8/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import Foundation

func printData(){
    var res = Course.all()
    //for c in res{
    var course = res[0] as Course
    println(course.title)
    println(course.capacity)
    println(course.catalogDescription)
    println(course.courseCode)
    println(course.currentEnrollment)
    println(course.days)
    println(course.endTime)
    println(course.startTime)
    println(course.term)
    println(course.year)
    println(course.building)
    println(course.instructor.name)
    for i in course.instructor.courses{
        println((i as Course).title)
    }
    println(course.subjectCode.name)
    for i in course.subjectCode.courses{
        println((i as Course).title)
    }
    //}
}

func loadCourses(){
    Course.deleteAll()
    SubjectCode.deleteAll()
    Instructor.deleteAll()
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
                    if let capacity  = c["Capacity"] as? NSNumber{
                        course.capacity = capacity
                    }
                    if let catalogDesc = c["CatalogDescription"] as? String{
                        course.catalogDescription = catalogDesc
                    }
                    if let courseCode = c["CourseCode"] as? NSString{
                        course.courseCode = courseCode
                    }
                    if let currentEnrollement = c["CurrentEnrollment"] as? NSNumber{
                        course.currentEnrollment = currentEnrollement
                    }
                    if let days = c["Days"] as? String{
                        course.days = days
                    }
                    if var endTimeString = c["EndTime"] as? String{
                        endTimeString += "UTC"
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssz"

                        var resDate : NSDate! = dateFormatter.dateFromString(endTimeString)
                        resDate = resDate.dateByAddingTimeInterval(-3600 * 6)
                        course.endTime = resDate
                    }
                    if var startTimeString = c["StartTime"] as? String{
                        startTimeString += "UTC"
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssz"

                        var resDate : NSDate! = dateFormatter.dateFromString(startTimeString)
                        
                        resDate = resDate.dateByAddingTimeInterval(-3600 * 6)
                        course.startTime = resDate
                    }
                    if let term = c["Term"] as? String{
                        course.term = term
                    }
                    if let year = c["Year"] as? String{
                        course.year = year
                    }
                    course.save()
                    if let instructor = c["Instructors"] as? String{
                        if let results = (Instructor.whereT("name == \"\(instructor)\"", limit: 1)){
                            if results.count > 0{
                                
                                var i = results[0] as Instructor
                                i.name = instructor
                                i.addCoursesObject(course)
                                course.instructor = i
                                i.save()
                            }
                            else{
                                var i = Instructor.create() as Instructor
                                i.name = instructor
                                i.addCoursesObject(course)
                                course.instructor = i
                                i.save()
                            }
                        }
                    }
                    if let subject = c["SubjectCode"] as? String{
                        if let results = (SubjectCode.whereT("name == \"\(subject)\"", limit: 1)){
                            if results.count > 0{
                                
                                var i = results[0] as SubjectCode
                                i.name = subject
                                i.addCoursesObject(course)
                                course.subjectCode = i
                                i.save()
                            }
                            else{
                                var i = SubjectCode.create() as SubjectCode
                                i.name = subject
                                i.addCoursesObject(course)
                                course.subjectCode = i
                                i.save()
                            }
                        }
                    }
                    course.save()
                }
            }
        }
        //printData()
       
        }) { (op: AFHTTPRequestOperation!, error:NSError!) -> Void in
        print(error)
    }
}