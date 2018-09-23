//
//  BarnsleyFernView.swift
//  BarnsleyFern
//
//  Created by Friedrich HAEUPL on 19.09.18.
//  Copyright © 2018 Friedrich HAEUPL. All rights reserved.
//

import Cocoa

class BarnsleyFernView: NSView {
    
    var mycurve = NSBezierPath()
    var centerPoint = NSPoint()
    var a = NSPoint()
    var b = NSPoint()
    
    var x:Double = 0
    var y:Double = 0
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // https://stackoverflow.com/questions/37501327/how-to-draw-a-circle-of-dots-that-are-individual-nodes-in-swift-spritekit?rq=1
        
        // https://learnappmaking.com/random-numbers-swift/
        // 4.2 let fraction = Float.random(in: 0 ..< 1)
        var d:Double = 0
        
        let startTime = CFAbsoluteTimeGetCurrent()
        //let start = clock()
        
        // Drawing code here.
        NSColor.white.setFill()
        self.bounds.fill()
        //
        mycurve.removeAllPoints()
        
        centerPoint.x = (self.bounds.origin.x + self.bounds.size.width)/2.0
        centerPoint.y = (self.bounds.origin.y + self.bounds.size.height)/2.0
        
        // Note that the complete fern is within the range
        // −2.1820 < x < 2.6558 and 0 ≤ y < 9.9983.
        let scale_x = self.bounds.size.width/(2.1820 + 2.6558)
        let scale_y = self.bounds.size.height/(9.9983)
        
        
        mycurve.move(to: centerPoint)
        
        for i in 0 ..< 10000 {
            
            d = drand48()
            
            if  d < 0.1 {
                
                //1
                x =  0
                y =  0.16 * y
            }
            else if d < 0.86 {
                //2
                x =   0.85 * x + 0.04 * y
                y =  -0.04 * x + 0.85 * y + 1.6
            }
            else if d < 0.93 {
                //3
                x =   0.2 * x - 0.26 * y
                y =   0.23 * x + 0.22 * y + 1.6
            }
            else {
                //4
                x =  -0.15 * x + 0.28 * y
                y =   0.26 * x + 0.24 * y + 0.44
            }
            
            a.x = centerPoint.x + CGFloat(Double(scale_y) * x)
            a.y = CGFloat(Double(scale_y) * y)
            
            let dotRect = NSRect(origin: a, size: NSSize(width: 1, height: 1))
            mycurve.appendOval(in: dotRect)
        }
        mycurve.stroke()
        
        
        
        let endTime = CFAbsoluteTimeGetCurrent()
        let result = endTime - startTime
        print("runtime:\t \(result) seconds")
        //let end  = clock()
        //print("running:\t \(end  - start) ns")
    }
}
