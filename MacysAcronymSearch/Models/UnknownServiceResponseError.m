//
//  UnknownServiceResponseError.m
//  Contacts
//
//  Created by Niyaz on 10/30/15.
//  Copyright © 2015 Niyaz. All rights reserved.
//

#import "UnknownServiceResponseError.h"

#define kOUnknownResponseObjectKey @"kOUnknownResponseObjectKey"

@implementation UnknownServiceResponseError

- (instancetype)initWithUnknownResponse:(id)responseObject {
    self = [super initWithDomain:@"" @"Unkown Response Object" code:NSURLErrorUnknown userInfo:responseObject ?
            @{kOUnknownResponseObjectKey: responseObject} : nil];
    return self;
}
@end
