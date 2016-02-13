//
//  CaliProjectsController.m
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliProjectsController.h"
#import "CaliProject.h"

@implementation CaliProjectsController

@synthesize currentProject;

- (id)currentDocument
{
    if ([self currentProject] != nil) {
        return [self currentProject];
    } else {
        return [super currentDocument];
    }
}

- (void)selectDocumentFromTheDock:(id)sender
{
    [NSApp activateIgnoringOtherApps:YES];
    [self selectDocument:[sender representedObject]];
}

- (void)selectDocument:(id)document
{
    NSArray *projects = [self documents];
    for (id project in projects) {
        NSArray *documents = [[(CaliProject *)project documents] allObjects];
        for (id item in documents) {
            if (item == document) {
                [[project window] makeKeyAndOrderFront:nil];
                [[project window] makeMainWindow];
                [[project window] makeFirstResponder:[document valueForKey:@"firstTextView"]];
                [project selectDocument:document];
                return;
            }
        }
    }
}

@end
