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

@implementation CaliProject

@synthesize leftDocumentsTableView;

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        project = [CaliBasic createNewObjectForEntity:@"Project"];
        //[[SMLProjectsController sharedDocumentController] setCurrentProject:self];
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.

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
