//
//  AcronymMeanings.m
//  MacysAcronymSearch
//
//  Created by Niyaz Ahmed on 10/30/15.
//  Copyright (c) 2015 Niyaz Ahmed. All rights reserved.
//

#import "AcronymMeanings.h"
#import "AcronymLongForm.h"

@implementation AcronymMeanings


+(instancetype) fromArray:(NSArray *)responseArray {
    AcronymMeanings* meanings = [AcronymMeanings new];
    NSDictionary* result = [responseArray firstObject];
    NSMutableArray* longForms = [NSMutableArray new];
    NSArray* lfs = result[@"lfs"];
    if(lfs) {
        [lfs enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
            [longForms addObject:[AcronymLongForm fromJson:obj]];
        }];
    }
    
    meanings.longForms = longForms;
    return meanings;
}

- (id)copyWithZone:(NSZone *)zone {
    AcronymMeanings *copy = [[[self class] allocWithZone:zone] init];
    copy.sf = self.sf;
    if(self.longForms) {
        copy.longForms = [[NSArray alloc] initWithArray:self.longForms copyItems:YES];
    }
    return copy;
}
@end
