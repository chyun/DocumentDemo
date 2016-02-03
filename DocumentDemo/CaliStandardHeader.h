//
//  CaliStandardHeader.h
//  DocumentDemo
//
//  Created by liqun.wu on 2/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define CaliBasic [CaliBasicPerformer sharedInstance]
#define CaliManagedObjectContext [[AppDelegate sharedInstance] managedObjectContext]

@interface CaliStandardHeader : NSObject

@end
