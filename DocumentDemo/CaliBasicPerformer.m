//
//  CaliBasicPerformer.m
//  DocumentDemo
//
//  Created by liqun.wu on 2/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliBasicPerformer.h"
#import "CaliStandardHeader.h"
#import "AppDelegate.h"

@implementation CaliBasicPerformer

static id sharedInstance = nil;

+ (CaliBasicPerformer *)sharedInstance
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
        
        thousandFormatter = [[NSNumberFormatter alloc] init];
        [thousandFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [thousandFormatter setFormat:@"#,##0"];
    }
    return sharedInstance;
}

- (id)createNewObjectForEntity:(NSString *)entity
{
    NSManagedObjectContext *managedObjectContext = [CaliManagedObjectContext init];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext: managedObjectContext];
    
    return object;
}

@end
