//
//  CaliBasicPerformer.h
//  DocumentDemo
//
//  Created by liqun.wu on 2/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaliBasicPerformer : NSObject {
    NSNumberFormatter *thousandFormatter;
    NSMutableDictionary *fetchRequests;
}

+ (CaliBasicPerformer *)sharedInstance;

- (id)createNewObjectForEntity:(NSString *)entity;

- (id)objectFromURI:(NSURL *)uri;

@end
