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

@end
