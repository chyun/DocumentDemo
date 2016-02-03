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

@end
