//
//  AppDelegate.h
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    
    BOOL shouldCreateEmptyDocument;
    BOOL hasFinishedLaunching;
    BOOL isTerminatingApplication;
}

@property (readonly) NSManagedObjectContext *managedObjectContext;
@property (readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly) NSManagedObjectModel *managedObjectModel;
@property (readonly) BOOL shouldCreateEmptyDocument, hasFinishedLaunching, isTerminatingApplication;

+ (AppDelegate *)sharedInstance;
@end

