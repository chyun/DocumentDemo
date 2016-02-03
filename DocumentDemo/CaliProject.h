//
//  Document.h
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaliProject : NSDocument<NSTableViewDelegate>
{
    NSManagedObject *project;
    IBOutlet NSView *leftDocumentsTableView;
    IBOutlet NSTableView *documentsTableView;
    IBOutlet NSTextField *statusBarTextField;
    
    IBOutlet NSSplitView *mainSplitView;
    //IBOutlet PSMTabBarControl *tabBarControl;
}



@property (readonly) IBOutlet NSSplitView *mainSplitView;
@property (readonly) IBOutlet NSView *leftDocumentsTableView;
@property (readonly) IBOutlet NSTableView *documentsTableView;
@property (readonly) IBOutlet NSTextField *statusBarTextField;


- (void)setDefaultAppearanceAtStartup;
- (NSWindow *)window;
- (void)resizeMainSplitView;

@end

