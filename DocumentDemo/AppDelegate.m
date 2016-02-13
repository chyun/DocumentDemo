//
//  AppDelegate.m
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "AppDelegate.h"
#import "CaliStandardHeader.h"
#import "CaliProjectsController.h"
#import "CaliProject.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator, managedObjectModel, managedObjectContext, shouldCreateEmptyDocument, hasFinishedLaunching, isTerminatingApplication;

static id sharedInstance = nil;

+ (AppDelegate *)sharedInstance
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
        shouldCreateEmptyDocument = YES;
    }
    
    return sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    
    // 获取实体模型文件对应的NSURL
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CaliDataModel3"
                                              withExtension:@"mom"];
    
    managedObjectModel = [[NSManagedObjectModel alloc]
                          initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSString *applicationSupportFolder = nil;
    NSError *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    applicationSupportFolder = [self applicationSupportFolder];
    if (![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL] ) {
        [fileManager createDirectoryAtPath:applicationSupportFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *storePath = [applicationSupportFolder stringByAppendingPathComponent: @"CaliText1.calitext"];
    
    NSURL *url = [NSURL fileURLWithPath:storePath];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSBinaryStoreType configuration:nil URL:url options:nil error:&error]){
        [[NSApplication sharedApplication] presentError:error];
    }
    
    return persistentStoreCoordinator;
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender
{
    NSLog(@"applicationDockMenu");
    NSMenu *returnMenu = [[NSMenu alloc] init];
    NSMenuItem *menuItem;
    id document;
    
    NSEnumerator *currentProjectEnumerator = [[[CaliCurrentProject documentsArrayController] arrangedObjects] reverseObjectEnumerator];
    for (document in currentProjectEnumerator) {
        menuItem = [[NSMenuItem alloc] initWithTitle:[document valueForKey:@"name"] action:@selector(selectDocumentFromTheDock:) keyEquivalent:@""];
        [menuItem setTarget:[CaliProjectsController sharedDocumentController]];
        [menuItem setRepresentedObject:document];
        [returnMenu insertItem:menuItem atIndex:0];
    }
    
    NSArray *projects = [[CaliProjectsController sharedDocumentController] documents];

    for (id project in projects) {
        if (project == CaliCurrentProject) {
            continue;
        }
    }

    return returnMenu;
}

- (NSString *)applicationSupportFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"CaliText"];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
