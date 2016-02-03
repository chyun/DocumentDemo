//
//  CaliViewMenuController.m
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliViewMenuController.h"
#import "CaliProjectsController.h"
#import "CaliProject.h"
#import "CaliStandardHeader.h"
#import "CaliInterfacePerformer.h"

@implementation CaliViewMenuController

static id sharedInstance = nil;

+ (CaliViewMenuController *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

- (id)init
{
    if (sharedInstance == nil) {
        sharedInstance = [super init];
    }
    return sharedInstance;
}

- (void)performHideStatusBar
{
    NSArray *array = [[CaliProjectsController sharedDocumentController] documents];
    for (id item in array) {
        CGFloat statusBarHeight = [[item statusBarTextField] bounds].size.height;
        NSRect mainSplitViewRect = [[item mainSplitView] frame];
        [CaliInterface clearStatusBar];
        [[item statusBarTextField] setHidden:YES];
        
        [[[item mainSplitView] animator] setFrame:NSMakeRect(mainSplitViewRect.origin.x, mainSplitViewRect.origin.y - statusBarHeight, mainSplitViewRect.size.width, mainSplitViewRect.size.height + statusBarHeight)];
        [[item mainSplitView] adjustSubviews];
    }
}



@end
