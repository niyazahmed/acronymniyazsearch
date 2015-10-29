//
//  NSString+MacysAdditions.m
//  Contacts
//
//  Created by Niyaz on 10/30/15.
//  Copyright © 2015 Niyaz. All rights reserved.
//

#import "NSString+MacysAdditions.h"

@implementation NSString (MacysAdditions)

- (BOOL)isPresent {
    NSString *trimmed = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return ([trimmed length] > 0);
}
@end
