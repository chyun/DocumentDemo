//
//  NSManagedObject+CoreDataProperties.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NSManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *shortEntityName;
@property (nullable, nonatomic, retain) NSString *uuid;

@end

NS_ASSUME_NONNULL_END
