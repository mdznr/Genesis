//
//  TouchOverlayWindow.m
//  HelloWorld
//
//  Created by Erica Sadun on 12/3/09.
//  Copyright 2009 Up To No Good, Inc.. All rights reserved.
//

#import "TouchOverlayWindow.h"
#import "TouchKitView.h"

@implementation TouchOverlayWindow
- (void) sendEvent:(UIEvent *)event
{
	NSSet *touches = [event allTouches];
	NSMutableSet *began = nil;
	NSMutableSet *moved = nil;
	NSMutableSet *ended = nil;
	NSMutableSet *cancelled = nil;
	
	// sort the touches by phase so we can handle them similarly to normal event dispatch
	for(UITouch *touch in touches) {
		switch ([touch phase]) {
			case UITouchPhaseBegan:
				if (!began) began = [NSMutableSet set];
				[began addObject:touch];
				break;
			case UITouchPhaseMoved:
				if (!moved) moved = [NSMutableSet set];
				[moved addObject:touch];
				break;
			case UITouchPhaseEnded:
				if (!ended) ended = [NSMutableSet set];
				[ended addObject:touch];
				break;
			case UITouchPhaseCancelled:
				if (!cancelled) cancelled = [NSMutableSet set];
				[cancelled addObject:touch];
				break;
			default:
				break;
		}
	}
    
	// call our methods to handle the touches
	if (began)     
        [[TouchKitView sharedInstance] touchesBegan:began withEvent:event];
	if (moved)     
        [[TouchKitView sharedInstance] touchesMoved:moved withEvent:event];
	if (ended)     
        [[TouchKitView sharedInstance] touchesEnded:ended withEvent:event];
	if (cancelled) 
        [[TouchKitView sharedInstance] touchesCancelled:cancelled withEvent:event];
    
    [super sendEvent: event];    
}
@end
