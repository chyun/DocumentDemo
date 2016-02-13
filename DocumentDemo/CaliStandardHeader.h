//
//  CaliStandardHeader.h
//  DocumentDemo
//
//  Created by liqun.wu on 2/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>


enum {
    CaliListView = 0
};

#define CaliInterface [CaliInterfacePerformer sharedInstance]
#define CaliBasic [CaliBasicPerformer sharedInstance]
#define CaliManagedObjectContext [[AppDelegate sharedInstance] managedObjectContext]
#define CaliDefaults [[NSUserDefaultsController sharedUserDefaultsController] values]
#define CaliInterface [CaliInterfacePerformer sharedInstance]
#define CaliCurrentProject [[CaliProjectsController sharedDocumentController] currentDocument]
#define CaliVarious [CaliVariousPerformer sharedInstance]
#define UNSAVED_STRING NSLocalizedString(@"(unsaved)", @"(unsaved)")

typedef NSUInteger CaliView;

@interface CaliStandardHeader : NSObject

@end
