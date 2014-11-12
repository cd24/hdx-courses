//
//  Schedule.h
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 11/11/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course;

@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * term;
@property (nonatomic, retain) NSSet *courses;
@end

@interface Schedule (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
