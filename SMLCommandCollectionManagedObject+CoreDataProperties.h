//
//  SMLCommandCollectionManagedObject+CoreDataProperties.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SMLCommandCollectionManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMLCommandCollectionManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *version;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *sortOrder;
@property (nullable, nonatomic, retain) NSString *uuid;
@property (nullable, nonatomic, retain) NSSet<SMLCommandManagedObject *> *commands;

@end

@interface SMLCommandCollectionManagedObject (CoreDataGeneratedAccessors)

- (void)addCommandsObject:(SMLCommandManagedObject *)value;
- (void)removeCommandsObject:(SMLCommandManagedObject *)value;
- (void)addCommands:(NSSet<SMLCommandManagedObject *> *)values;
- (void)removeCommands:(NSSet<SMLCommandManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
