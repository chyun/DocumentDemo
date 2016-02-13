//
//  CaliTextView.m
//  DocumentDemo
//
//  Created by liqun.wu on 11/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliTextView.h"

@implementation CaliTextView

@synthesize inCompleteMethod;

- (id)initWithFrame:(NSRect)frame
{
    NSLog(@"CaliTextView initWithFrame");
//    if (self = [super initWithFrame:frame]) {
//        SMLLayoutManager *layoutManager = [[SMLLayoutManager alloc] init];
//        [[self textContainer] replaceLayoutManager:layoutManager];
//        
//        [self setDefaults];
//    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
