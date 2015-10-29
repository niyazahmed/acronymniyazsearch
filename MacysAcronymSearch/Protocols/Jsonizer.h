//
//  Jsonizer.h
//  Contacts
//
//  Created by Niyaz on 10/30/15.
//  Copyright © 2015 Niyaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Jsonizer <NSObject>

@optional
+ (instancetype)fromJson:(NSDictionary *)jsonDict;
+ (instancetype) fromArray:(NSArray*) responseArray;


@end
