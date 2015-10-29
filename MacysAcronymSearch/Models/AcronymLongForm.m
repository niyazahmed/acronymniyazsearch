//
//  AcronymLongForm.m
//  MacysAcronymSearch
//
//  Created by Niyaz Ahmed on 10/30/15.
//  Copyright (c) 2015 Niyaz Ahmed. All rights reserved.
//

#import "AcronymLongForm.h"

@implementation AcronymLongForm

+(instancetype) fromJson:(NSDictionary *)jsonDict {
    AcronymLongForm* longForm = [AcronymLongForm new];
    longForm.lf = jsonDict[@"lf"];
    longForm.freq = jsonDict[@"freq"];
    longForm.since = jsonDict[@"since"];
    return longForm;
}

- (id)copyWithZone:(NSZone *)zone {
    AcronymLongForm *copy = [[[self class] allocWithZone:zone] init];
    copy.lf = self.lf;
    copy.freq = self.freq;
    copy.since = self.since;
    return copy;
}

@end
