//
//  CaliProject+TableViewDelegate.m
//  DocumentDemo
//
//  Created by liqun.wu on 11/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliProject+TableViewDelegate.h"
#import "CaliInterfacePerformer.h"
#import "CaliStandardHeader.h"
#import "AppDelegate.h"

@implementation CaliProject (TableViewDelegate)

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    //加载的时候被调用了一次
    NSLog(@"tableViewSelectionDidChange");
    NSTableView *tableView = [aNotification object];
    if (tableView == [self documentsTableView] || aNotification == nil) {
        if ([[AppDelegate sharedInstance] isTerminatingApplication] == YES) {
            return;
        }
        if ([[[self documentsArrayController] arrangedObjects] count] < 1 || [[[self documentsArrayController] selectedObjects] count] < 1) {
            [self updateWindowTitleBarForDocument:nil];
            return;
        }
        
        id document = [[[self documentsArrayController] selectedObjects] objectAtIndex:0];
        
        [self performInsertFirstDocument:document];
        
    }
    
}


- (void)performInsertFirstDocument:(id)document
{
    NSLog(@"performInsertFirstDocument");
    [self setFirstDocument:document];
    
    [CaliInterface removeAllSubviewsFromView:firstContentView];
    [firstContentView addSubview:[document valueForKey:@"firstTextScrollView"]];
    if ([[document valueForKey:@"showLineNumberGutter"] boolValue] == YES) {
        [firstContentView addSubview:[document valueForKey:@"firstGutterScrollView"]];
    }
    
    [self updateWindowTitleBarForDocument:document];
    [self resizeViewsForDocument:document]; // If the window has changed since the view was last visible
    [[self documentsTableView] scrollRowToVisible:[[self documentsTableView] selectedRow]];
    
    [[self window] makeFirstResponder:[document valueForKey:@"firstTextView"]];
//    [[document valueForKey:@"lineNumbers"] updateLineNumbersForClipView:[[document valueForKey:@"firstTextScrollView"] contentView] checkWidth:NO recolour:YES]; // If the window has changed since the view was last visible
//    [SMLInterface updateStatusBar];
//    
//    [self selectSameDocumentInTabBarAsInDocumentsList];
}
@end
