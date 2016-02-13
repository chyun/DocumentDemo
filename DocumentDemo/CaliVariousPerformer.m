//
//  CaliVariousPerformer.m
//  DocumentDemo
//
//  Created by liqun.wu on 13/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliVariousPerformer.h"
#import "CaliStandardHeader.h"

@implementation CaliVariousPerformer

static id sharedInstance = nil;

+ (CaliVariousPerformer *)sharedInstance
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
        untitledNumber = 1;
        
        isChangingSyntaxDefinitionsProgrammatically = NO; // So that SMLManagedObject does not need to care about changes when resetting the preferences
    }
    return sharedInstance;
}

- (BOOL)isChangingSyntaxDefinitionsProgrammatically
{
    return isChangingSyntaxDefinitionsProgrammatically;
}

- (void)setUnsavedAsLastSavedDateForDocument:(id)document
{
    [document setValue:UNSAVED_STRING forKey:@"lastSaved"];
}


@end
