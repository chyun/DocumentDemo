//
//  CaliDragAndDropController.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaliDragAndDropController : NSObject <NSTableViewDataSource> {
    NSString *movedDocumentType;
    NSString *movedSnippetType;
    NSString *movedCommandType;
}

+ (CaliDragAndDropController *)sharedInstance;

- (void)moveObjects:(NSArray *)objects inArrayController:(NSArrayController *)arrayController fromIndexes:(NSIndexSet *)rowIndexes toIndex:(NSInteger)insertIndex;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;

@end
