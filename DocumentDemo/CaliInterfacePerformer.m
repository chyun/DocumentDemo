//
//  CaliInterfacePerformer.m
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliInterfacePerformer.h"
#import "CaliStandardHeader.h"
#import "CaliProjectsController.h"
#import "CaliProject.h"

@implementation CaliInterfacePerformer

@synthesize fullScreenDocument, defaultIcon, defaultUnsavedIcon;

static id sharedInstance = nil;

+ (CaliInterfacePerformer *)sharedInstance
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
        
        statusBarBetweenString = [[NSString alloc] initWithFormat:@"  %C  ", 0x00B7];
        statusBarLastSavedString = NSLocalizedString(@"Saved", @"Saved, in the status bar");
        statusBarDocumentLengthString = NSLocalizedString(@"Length", @"Length, in the status bar");
        statusBarSelectionLengthString = NSLocalizedString(@"Selection", @"Selection, in the status bar");
        statusBarPositionString = NSLocalizedString(@"Position", @"Position, in the status bar");
        statusBarSyntaxDefinitionString = NSLocalizedString(@"Syntax", @"Syntax, in the status bar");
        statusBarEncodingString = NSLocalizedString(@"Encoding", @"Encoding, in the status bar");
        
        defaultIcon = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SMLDefaultIcon" ofType:@"png"]];
        defaultUnsavedIcon = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SMLDefaultUnsavedIcon" ofType:@"png"]];
    }
    return sharedInstance;
}

- (void)clearStatusBar
{
    [[CaliCurrentProject statusBarTextField] setObjectValue:@""];
}

- (void)removeAllSubviewsFromView:(NSView *)view
{
    [view setSubviews:[NSArray array]];
    NSLog(@"TODO: removeAllSubviewsFromView");
    //NSArray *array = [NSArray arrayWithArray:[view subviews]];
    //	id item;
    //	for (item in array) {
    //		[item removeFromSuperview];
    //		item = nil;
    //	}
}

- (void)updateStatusBar {
    NSLog(@"TODO: updateStatusBar");
}

@end
