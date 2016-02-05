//
//  Document.h
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PSMTabBarControl.h"

@interface CaliProject : NSDocument<NSTableViewDelegate>
{
    NSManagedObject *project;
    IBOutlet NSView *leftDocumentsView;
    IBOutlet NSView *leftDocumentsTableView;
    IBOutlet NSTableView *documentsTableView;
    IBOutlet NSTextField *statusBarTextField;
    
    IBOutlet NSSplitView *mainSplitView;
    IBOutlet NSSplitView *contentSplitView;
    
    IBOutlet PSMTabBarControl *tabBarControl;
    IBOutlet NSView *viewSelectionView;
}


@property (readonly) IBOutlet NSSplitView *contentSplitView;
@property (readonly) IBOutlet NSSplitView *mainSplitView;
@property (readonly) IBOutlet NSView *leftDocumentsView;
@property (readonly) IBOutlet NSView *leftDocumentsTableView;
@property (readonly) IBOutlet NSTableView *documentsTableView;
@property (readonly) IBOutlet NSTextField *statusBarTextField;
@property (readonly) IBOutlet PSMTabBarControl *tabBarControl;


- (void)setDefaultAppearanceAtStartup;
- (NSWindow *)window;
- (void)resizeMainSplitView;

@end

