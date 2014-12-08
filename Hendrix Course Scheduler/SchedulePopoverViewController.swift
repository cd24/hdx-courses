//
//  SchedulePopoverViewController.swift
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 11/11/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import Foundation

class SchedulePopoverViewController : UITableViewController{
    var sched : Array<Schedule> = []
    var selectedIdx : Int = 0
    var parent: CourseViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "add")
        var query = Schedule.all()
        for i in query{
            var temp = i as Schedule
            if current_schedule != nil {
                if temp.name == current_schedule.name {
                    selectedIdx = sched.count
                }
            }
            sched.append(temp)
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    func set_selected() {
        
    }
    
    func addWithSchedule(incoming : Schedule){
        if incoming.name == "" || incoming.name == nil {
            sched.append(incoming)
        }
        self.tableView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismiss_empty() {
        self.tableView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "add" {
            var nav = segue.destinationViewController as UINavigationController
            var newView = nav.topViewController as NewScheduleController
            newView.pres = self
        }
    }
    func add(){
        self.performSegueWithIdentifier("add", sender: self)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = sched[indexPath.row].name
        if indexPath.row == selectedIdx{
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var schedule = sched[indexPath.row]
            sched.removeAtIndex(indexPath.row)
            schedule.delete()
            schedule.save()
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sched.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIdx = indexPath.row
        current_schedule = sched[indexPath.row]
        update_schedule()
        self.tableView.reloadData()
    }
}

class NewScheduleController : XLFormViewController{
    var pres : SchedulePopoverViewController!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createForm()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        createForm()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "done")
    }
    func done(){
        var res = self.formValues()
        var in_use = false
        //Check if the name is in use
        var existing = Schedule.all()
        if let sched_name = res["name"] as? String{
            for s in existing {
                var sc = s as Schedule
                if sched_name == sc.name {
                    in_use = true
                }
            }
            
            if in_use {
                var alert_view = UIAlertView(title: "That name is already taken", message: "The schedule name you have enetered is already in use.  You should either delete  or modify the existing schedule", delegate: nil, cancelButtonTitle: "Close", otherButtonTitles: "Ok")
                alert_view.show()
            }
            else{
                var newSchedule = Schedule.create() as Schedule
                newSchedule.name = (res["name"] as String)
                newSchedule.term = (res["term"] as XLFormOptionsObject).displayText() as String
                newSchedule.year = (res["year"] as XLFormOptionsObject).displayText() as String
                newSchedule.save()
                pres.addWithSchedule(newSchedule)
            }
        }
        else {
            pres.dismiss_empty()
        }
    }
    func createForm(){
        var form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "New Schedule")
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Schedule Name") as XLFormSectionDescriptor
        
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "name", rowType: XLFormRowDescriptorTypeText, title: "Name")
        section.addFormRow(row)
        
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Semester") as XLFormSectionDescriptor
        
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "year", rowType: XLFormRowDescriptorTypeSelectorPickerViewInline,title: "Year")
        var yearOptions : Array<XLFormOptionsObject> = []
        var temp = ["07-08","08-09","09-10","10-11","11-12","12-13","13-14","14-15","15-16"]
        for year in temp{
            yearOptions.append(XLFormOptionsObject(value: year, displayText: year))
        }
        row.selectorOptions = yearOptions
        row.value = yearOptions[0]
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "term", rowType: XLFormRowDescriptorTypeSelectorPickerViewInline,title: "Term")
        var termOptions : Array<XLFormOptionsObject> = []
        var temp2 = [(0,"Fall"),(1,"Spring")]
        for (id,name) in temp2{
            termOptions.append(XLFormOptionsObject(value: id, displayText: name))
        }
        row.selectorOptions = termOptions
        row.value = termOptions[0]
        section.addFormRow(row)
        
        self.form = form
    }
}