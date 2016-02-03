//
//  SMLSnippetCollectionManagedObject+CoreDataProperties.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SMLSnippetCollectionManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMLSnippetCollectionManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *version;
@property (nullable, nonatomic, retain) NSNumber *sortOrder;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *uuid;
@property (nullable, nonatomic, retain) NSSet<SMLSnippetManagedObject *> *snippets;

@end

@interface SMLSnippetCollectionManagedObject (CoreDataGeneratedAccessors)

- (void)addSnippetsObject:(SMLSnippetManagedObject *)value;
- (void)removeSnippetsObject:(SMLSnippetManagedObject *)value;
- (void)addSnippets:(NSSet<SMLSnippetManagedObject *> *)values;
- (void)removeSnippets:(NSSet<SMLSnippetManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
