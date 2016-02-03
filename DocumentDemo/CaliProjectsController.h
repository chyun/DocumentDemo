//
//  CaliProjectsController.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class CaliProject;

@interface CaliProjectsController : NSDocumentController

@property (assign) CaliProject *currentProject;

- (id)currentDocument;

@end
