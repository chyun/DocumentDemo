//
//  SMLEncodingManagedObject+CoreDataProperties.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SMLEncodingManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMLEncodingManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *encoding;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *active;

@end

NS_ASSUME_NONNULL_END
