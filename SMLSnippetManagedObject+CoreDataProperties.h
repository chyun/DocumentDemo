//
//  SMLSnippetManagedObject+CoreDataProperties.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SMLSnippetManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMLSnippetManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *shortcutDisplayString;
@property (nullable, nonatomic, retain) NSNumber *sortOrder;
@property (nullable, nonatomic, retain) NSString *shortcutMenuItemKeyString;
@property (nullable, nonatomic, retain) NSNumber *shortcutModifier;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSNumber *version;
@property (nullable, nonatomic, retain) NSString *uuid;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *collectionName;
@property (nullable, nonatomic, retain) SMLSnippetCollectionManagedObject *snippetCollection;

@end

NS_ASSUME_NONNULL_END