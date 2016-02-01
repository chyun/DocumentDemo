//
//  Document.m
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

//NOTE: 创建NSDocument的子类时要注意, xyz.xib, xyz.h, xyz.m, 以及windowNibName中的名字要相同
#import "CaliProject.h"

@interface CaliProject ()

@end

@implementation CaliProject

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
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
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
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