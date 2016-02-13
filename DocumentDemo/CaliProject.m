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
#import "AppDelegate.h"
#import "CaliStandardHeader.h"
#import "CaliVariousPerformer.h"
#import "CaliInterfacePerformer.h"


@implementation CaliProject

@synthesize documentsTableView, leftDocumentsTableView, statusBarTextField, mainSplitView, contentSplitView, leftDocumentsView, tabBarControl, firstContentView, documentsArrayController;

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
    
    if ([[AppDelegate sharedInstance] shouldCreateEmptyDocument] == YES) {
        NSLog(@"shouldCreateEmptyDocument");
        id document = [self createNewDocumentWithContents:@""];
        [self insertDefaultIconsInDocument:document];
        [self selectionDidChange];
    }
}

- (void)insertDefaultIconsInDocument:(id)document
{
//    NSImage *defaultIcon = [SMLInterface defaultIcon];
//    [defaultIcon setScalesWhenResized:YES];
//    
//    NSImage *defaultUnsavedIcon = [SMLInterface defaultUnsavedIcon];
//    [defaultUnsavedIcon setScalesWhenResized:YES];
//    
//    [document setValue:defaultIcon forKey:@"icon"];
//    [document setValue:defaultUnsavedIcon forKey:@"unsavedIcon"];
    NSLog(@"TODO: insertDefaultIconsInDocument");
}

- (id)createNewDocumentWithContents:(NSString *)textString
{
    id document = [self createNewDocumentWithPath:nil andContents:textString];
    
    [document setValue:[NSNumber numberWithBool:YES] forKey:@"isNewDocument"];
    [CaliVarious setUnsavedAsLastSavedDateForDocument:document];
    [CaliInterface updateStatusBar];
    
    return document;
}

- (void)selectionDidChange
{
    [self tableViewSelectionDidChange:[NSNotification notificationWithName:@"NSTableViewSelectionDidChangeNotification" object:documentsTableView]];
}

- (id)createNewDocumentWithPath:(NSString *)path andContents:(NSString *)textString
{
    //创建管理对象
    id document = [CaliBasic createNewObjectForEntity:@"Document"];
    
    [[self documents] addObject:document];
    
//    [CaliVarious setNameAndPathForDocument:document path:path];
//    [CaliInterface createFirstViewForDocument:document];
//    
//    [[document valueForKey:@"firstTextView"] setString:textString];
//    
//    SMLSyntaxColouring *syntaxColouring = [[SMLSyntaxColouring alloc] initWithDocument:document];
//    [document setValue:syntaxColouring forKey:@"syntaxColouring"];
//    
//    [[document valueForKey:@"lineNumbers"] updateLineNumbersForClipView:[[document valueForKey:@"firstTextScrollView"] contentView] checkWidth:NO recolour:YES];
//    [document setValue:[NSNumber numberWithInteger:[[documentsArrayController arrangedObjects] count]] forKey:@"sortOrder"];
//    [self documentsListHasUpdated];
//    
//    [documentsArrayController setSelectedObjects:[NSArray arrayWithObject:document]];
//    
//    [document setValue:[NSString localizedNameOfStringEncoding:[[document valueForKey:@"encoding"] integerValue]] forKey:@"encodingName"];
    
    return document;
}

#pragma mark -
#pragma mark Others

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

- (void)updateWindowTitleBarForDocument:(id)document
{
    NSLog(@"updateWindowTitleBarForDocument");
    NSWindow *currentWindow = [self window];
    NSString *projectName = nil;
    if ([self name] != nil) {
        projectName = [self name];
    }
    
    if ([self areThereAnyDocuments] == YES && document != nil) {
        
    } else {
        [currentWindow setDocumentEdited:NO];
        [currentWindow setRepresentedFilename:[[NSBundle mainBundle] bundlePath]];
        [currentWindow setTitle:@"CaliText"];
    }
}

- (BOOL)areThereAnyDocuments
{
    if ([[documentsArrayController arrangedObjects] count] > 0) {
        return YES;
    } else {
        return NO;
    }
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

- (NSString *)name
{
    if ([self fileURL] == nil) {
        return nil;
    }
    
//    NSString *urlString = (NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)[[self fileURL] absoluteString], CFSTR(""), kCFStringEncodingUTF8);
//    
//    
//    NSMakeCollectable(urlString);
//    return [[urlString lastPathComponent] stringByDeletingPathExtension];
    return @"Name to implement";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    //return [text dataUsingEncoding:NSUTF8StringEncoding];
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {

    return YES;
}

@end
