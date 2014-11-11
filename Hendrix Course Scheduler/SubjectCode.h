//
//  SubjectCode.h
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 11/10/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course;

@interface SubjectCode : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *courses;
@end

@interface SubjectCode (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
