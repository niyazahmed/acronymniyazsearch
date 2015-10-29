
//  UnknownServiceResponseError.h
//  Contacts
//
//  Created by Niyaz on 10/30/15.
//  Copyright © 2015 Niyaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnknownServiceResponseError : NSError

- (instancetype)initWithUnknownResponse:(id)responseObject;
@end
