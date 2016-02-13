//
//  CaliTextView.h
//  DocumentDemo
//
//  Created by liqun.wu on 11/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CaliTextView;

@interface CaliTextView : NSTextView {
    NSInteger lineHeight;
    NSPoint startPoint;
    NSPoint startOrigin;
    CGFloat pageGuideX;
    NSColor *pageGuideColour;
    
    BOOL showPageGuide;
    
    //NSCursor *colouredIBeamCursor;
    
    BOOL inCompleteMethod;
}

@property (assign) NSCursor *colouredIBeamCursor;
@property (assign) BOOL inCompleteMethod;

//- (void)setDefaults;

//- (NSInteger)lineHeight;

//- (void)setTabWidth;

//- (void)setPageGuideValues;

//- (void)updateIBeamCursor;

@end
