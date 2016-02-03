//
//  SMLSyntaxDefinitionManagedObject+CoreDataProperties.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SMLSyntaxDefinitionManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMLSyntaxDefinitionManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *extensions;
@property (nullable, nonatomic, retain) NSNumber *sortOrder;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *file;

@end

NS_ASSUME_NONNULL_END
