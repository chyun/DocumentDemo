//
//  Document.m
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

//NOTE: 创建NSDocument的子类时要注意, xyz.xib, xyz.h, xyz.m, 以及windowNibName中的名字要相同
#import "CaliProject.h"
#import "CaliBasicPerformer.h"
#import "CaliStandardHeader.h"
#import "CaliDocumentsListCell.h"
#import "CaliViewMenuController.h"
#import "CaliProject+DocumentViewsController.h"
#import "CaliDragAndDropController.h"

@implementation CaliProject

@synthesize documentsTableView, leftDocumentsTableView, statusBarTextField, mainSplitView, contentSplitView, leftDocumentsView, tabBarControl;

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        //project = [CaliBasic createNewObjectForEntity:@"SyntaxDefinition"];
        //[[SMLProjectsController sharedDocumentController] setCurrentProject:self];
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    NSLog(@"windowControllerDidLoadNib");
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    [[[self windowControllers] objectAtIndex:0] setWindowFrameAutosaveName:@"CaliTextProjectWindow"];
    [[self window] setFrameAutosaveName:@"CaliTextProjectWindow"];
    
    [self setDefaultAppearanceAtStartup];
    
    [self setDefaultViews];
    
    [documentsTableView setDelegate:self];
    NSLog(@"Table view delegate has been set");
    
    [documentsTableView setDataSource:[CaliDragAndDropController sharedInstance]];
    [documentsTableView setDraggingSourceOperationMask:NSDragOperationLink forLocal:NO];
    [documentsTableView setDraggingSourceOperationMask:NSDragOperationLink forLocal:YES];
    
    //[documentsTableView registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, NSStringPboardType, @"CaliMovedDocumentType", nil]];
    
    //[documentsTableView setDraggingSourceOperationMask:(NSDragOperationCopy | NSDragOperationMove) forLocal:NO];
}

- (void)setDefaultAppearanceAtStartup
{
    [[statusBarTextField cell] setBackgroundStyle:NSBackgroundStyleRaised];
    
    CaliDocumentsListCell *cell = [[CaliDocumentsListCell alloc] init];
    [cell setWraps:NO];
    [cell setLineBreakMode:NSLineBreakByTruncatingMiddle];
    [[documentsTableView tableColumnWithIdentifier:@"name"] setDataCell:cell];
    
    if ([[CaliDefaults valueForKey:@"ShowStatusBar"] boolValue] == NO) {
        [[CaliViewMenuController sharedInstance] performHideStatusBar];
    }
    
//    if ([[CaliDefaults valueForKey:@"ShowTabBar"] boolValue] == NO) {
//        CGFloat tabBarHeight = [tabBarControl bounds].size.height;
//        NSRect mainSplitViewRect = [mainSplitView frame];
//        [tabBarControl setHidden:YES];
//        [mainSplitView setFrame:NSMakeRect(mainSplitViewRect.origin.x, mainSplitViewRect.origin.y, mainSplitViewRect.size.width, mainSplitViewRect.size.height + tabBarHeight)];
//    } else {
//        [self updateTabBar];
//    }
    
    if ([project valueForKey:@"dividerPosition"] == nil) {
        [project setValue:[CaliDefaults valueForKey:@"DividerPosition"] forKey:@"dividerPosition"];
    }
    [self resizeMainSplitView];
    
}

- (void)resizeMainSplitView
{
    NSRect leftDocumentsViewFrame = [[[mainSplitView subviews] objectAtIndex:0] frame];
    NSRect contentViewFrame = [[[mainSplitView subviews] objectAtIndex:1] frame];
    CGFloat totalWidth = leftDocumentsViewFrame.size.width + contentViewFrame.size.width + [mainSplitView dividerThickness];
    leftDocumentsViewFrame.size.width = [[project valueForKey:@"dividerPosition"] doubleValue] * totalWidth;
    contentViewFrame.size.width = totalWidth - leftDocumentsViewFrame.size.width - [mainSplitView dividerThickness];
    
    [[[mainSplitView subviews] objectAtIndex:0] setFrame:leftDocumentsViewFrame];
    [[[mainSplitView subviews] objectAtIndex:1] setFrame:contentViewFrame];
    
    [mainSplitView adjustSubviews];
}

- (NSMutableSet *)documents
{
    return [project mutableSetValueForKey:@"documents"];
}

- (NSWindow *)window
{
    return [[[self windowControllers] objectAtIndex:0] window];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSString *)windowNibName {
    return @"CaliProject";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    //return [text dataUsingEncoding:NSUTF8StringEncoding];
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {

    return YES;
}

@end
