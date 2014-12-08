//
//  CalendarViewController.swift
//  Hendrix Course Scheduler
//
//  Created by Connor Bell on 11/11/14.
//  Copyright (c) 2014 Survey Dream. All rights reserved.
//

import Foundation

class CalendarViewController : UIViewController{
    var daysViews : Array<DayView> = []
    override func viewDidLoad() {
        self.navigationItem.title = "Calendar"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Courses", style: UIBarButtonItemStyle.Plain, target: self, action: "dismiss")
        var width = Double(self.view.frame.size.width) / 5.0
        var days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
        for i in 0..<5{
            var xPos = Double(i) * width
            
            var day = DayView(frame: CGRectMake(CGFloat(xPos), 0, CGFloat(width), self.view.frame.size.height - 64))
            day.headerLabel.text = days[i]
            day.addEvent(10,halfStart:true, endTime: 13,halfEnd:true, title: "Lunch")
            daysViews.append(day)
            self.view.addSubview(day)
        }
    }
    func dismiss(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

class DayView: UIView{
    var headerLabel : UILabel!
    var wholeHours: Array<UIView> = []
    var halfHours: Array<UIView> = []
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.layer.borderColor = UIColor.orangeColor().CGColor
        self.layer.borderWidth = 2.0
        headerLabel = UILabel(frame: CGRectMake(0, 0, frame.size.width, 45))
        headerLabel.textColor = UIColor.orangeColor()
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.font = UIFont.systemFontOfSize(headerLabel.font.pointSize + 5.0)
        self.addSubview(headerLabel)
        for i in 0...24{
            var topMargin = 45.0
            var bottomMargin = 15.0
            var calcHeight = frame.size.height - CGFloat(topMargin + bottomMargin)
            var newI = Float(i) + 0.5
            var yPos = Double(i) * Double(calcHeight) / 24.0 + topMargin
            var yPos2 = Double(newI) * Double(calcHeight) / Double(24.0) + topMargin
            
            var bar = UIView(frame: CGRectMake(35, CGFloat(yPos),frame.size.width - 39, 1))
            bar.backgroundColor = UIColor.grayColor()
            wholeHours.append(bar)
            
            var halfBar = UIView(frame: CGRectMake(35, CGFloat(yPos2), frame.size.width - 39, 1))
            halfBar.backgroundColor = UIColor.lightGrayColor()
            halfHours.append(halfBar)
            
            var label = UILabel(frame: CGRectMake(2, CGFloat(yPos - 10), 27, 20))
            label.textAlignment = NSTextAlignment.Right
            label.text = "\((i + 11) % 12 + 1)"
            self.addSubview(label)
            self.addSubview(halfBar)
            self.addSubview(bar)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addEvent(startTime: Int,halfStart : Bool, endTime: Int, halfEnd: Bool, title: String){
        var startY : CGFloat//= wholeHours[startTime].frame.origin.y
        var endY : CGFloat //= wholeHours[endTime].frame.origin.y
        if halfStart{
            startY = halfHours[startTime].frame.origin.y
        }
        else{
            startY = wholeHours[startTime].frame.origin.y
        }
        if halfEnd{
            endY = halfHours[endTime].frame.origin.y
        }
        else{
            endY = wholeHours[endTime].frame.origin.y
        }
        var height = endY - startY
        var calEve = CalendarEvent(frame: CGRectMake(37, startY, frame.size.width - 43, height))
        calEve.label.text = title
        self.addSubview(calEve)
    }
}

class CalendarEvent : UIView{
    var label : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
        var greenColor = UIColor.greenColor()
        var darkGreen = darkerColorForColor(greenColor)
        self.alpha = 0.95
        self.layer.borderColor = darkGreen.CGColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 10.0
        label = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
        self.clipsToBounds = true
    }
    func darkerColorForColor(c : UIColor) -> UIColor!{
        var r : CGFloat = 0.0, g : CGFloat = 0.0, b : CGFloat = 0.0, a : CGFloat = 0.0
        if c.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red:max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue:max(b - 0.2, 0.0), alpha: a)
        }
        return nil
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}