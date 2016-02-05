//
//  CaliDragAndDropController.m
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliDragAndDropController.h"
#import "CaliStandardHeader.h"
#import "CaliBasicPerformer.h"

@implementation CaliDragAndDropController

static id sharedInstance = nil;

+ (CaliDragAndDropController *)sharedInstance
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
        
        movedDocumentType = @"CaliMovedDocumentType";
        movedSnippetType = @"CaliMovedSnippetType";
        movedCommandType = @"CaliMovedCommandType";
    }
    NSLog(@"CaliDragAndDropController has been initialized");
    return sharedInstance;
}

- (void)moveObjects:(NSArray *)objects inArrayController:(NSArrayController *)arrayController fromIndexes:(NSIndexSet *)rowIndexes toIndex:(NSInteger)insertIndex
{
    NSMutableArray *arrangedObjects = [NSMutableArray arrayWithArray:[arrayController arrangedObjects]];
    
    if (arrangedObjects == nil || objects == nil) {
        return;
    }
    
    NSUInteger currentIndex = [rowIndexes firstIndex];
    while (currentIndex != NSNotFound) {
        [arrangedObjects replaceObjectAtIndex:currentIndex withObject:[NSNull null]];
        currentIndex = [rowIndexes indexGreaterThanIndex:currentIndex];
    }
    
    NSEnumerator *enumerator = [objects reverseObjectEnumerator];
    id item;
    for (item in enumerator) {
        [arrangedObjects insertObject:[CaliBasic objectFromURI:item] atIndex:insertIndex];
    }
    
    [arrangedObjects removeObject:[NSNull null]];
    
    NSInteger index = 0;
    for (item in arrangedObjects) {
        [item setValue:[NSNumber numberWithInteger:index] forKey:@"sortOrder"];
        index++;
    }
    
    [arrayController setContent:arrangedObjects];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    long recordCount = [self.dataArray count];
    return recordCount;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    NSString *aString;
    aString = [[self.dataArray objectAtIndex:rowIndex] objectForKey:[aTableColumn identifier]];
    return aString;
}

- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation
{
    NSLog(@"released mouse");
    return YES;
}

- (NSDragOperation)tableView:(NSTableView *)aTableView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)operation
{
    NSLog(@"tableView validateDrop");
    return NSDragOperationCopy;
}

- (BOOL)tableView:(NSTableView *)aTableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard
{
    NSLog(@"tableView writeRowsWithIndexes");
    return YES;
}

-(NSArray *)dataArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:@"1001",@"key1",@"1002",@"key2",@"1003",@"key3",@"1004",@"key4",@"1005",@"key5",@"1006",@"key6",@"1007",@"key7", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"2001",@"key1",@"2002",@"key2",@"2003",@"key3",@"2004",@"key4",@"2005",@"key5",@"2006",@"key6",@"2007",@"key7", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"3001",@"key1",@"3002",@"key2",@"3003",@"key3",@"3004",@"key4",@"3005",@"key5",@"3006",@"key6",@"3007",@"key7", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"4001",@"key1",@"4002",@"key2",@"4003",@"key3",@"4004",@"key4",@"4005",@"key5",@"4006",@"key6",@"4007",@"key7", nil],
                      nil];
    return array;
}

@end
