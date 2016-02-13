//
//  Document.h
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PSMTabBarControl.h"
#import "CaliDocumentManagedObject.h"

@interface CaliProject : NSDocument<NSTableViewDelegate>
{
    NSManagedObject *project;
    CaliDocumentManagedObject *firstDocument;
    
    IBOutlet NSView *leftDocumentsView;
    IBOutlet NSView *leftDocumentsTableView;
    IBOutlet NSTableView *documentsTableView;
    IBOutlet NSTextField *statusBarTextField;
    
    IBOutlet NSSplitView *mainSplitView;
    IBOutlet NSSplitView *contentSplitView;
    
    IBOutlet PSMTabBarControl *tabBarControl;
    IBOutlet NSView *viewSelectionView;
    IBOutlet NSView *firstContentView;
    
    IBOutlet NSArrayController *documentsArrayController;
    
}

@property (assign) CaliDocumentManagedObject *firstDocument;

@property (readonly) IBOutlet NSSplitView *contentSplitView;

@property (readonly) IBOutlet NSSplitView *mainSplitView;
@property (readonly) IBOutlet NSView *leftDocumentsView;
@property (readonly) IBOutlet NSView *leftDocumentsTableView;
@property (readonly) IBOutlet NSTableView *documentsTableView;
@property (readonly) IBOutlet NSTextField *statusBarTextField;
@property (readonly) IBOutlet PSMTabBarControl *tabBarControl;
@property (readonly) IBOutlet NSView *firstContentView;
@property (readonly) IBOutlet NSArrayController *documentsArrayController;



- (void)setDefaultAppearanceAtStartup;
- (NSWindow *)window;
- (void)resizeMainSplitView;
- (void)updateWindowTitleBarForDocument:(id)document;
- (void)resizeViewsForDocument:(id)document;
- (NSMutableSet *)documents;
- (id)createNewDocumentWithContents:(NSString *)textString;
- (id)createNewDocumentWithPath:(NSString *)path andContents:(NSString *)textString;
- (void)insertDefaultIconsInDocument:(id)document;
- (void)selectionDidChange;

@end

