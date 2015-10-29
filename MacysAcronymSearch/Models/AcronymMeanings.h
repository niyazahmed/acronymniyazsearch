//
//  AcronymMeanings.h
//  MacysAcronymSearch
//
//  Created by Niyaz Ahmed on 10/30/15.
//  Copyright (c) 2015 Niyaz Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jsonizer.h"
@interface AcronymMeanings : NSObject<Jsonizer,NSCopying>

@property(nonatomic,strong) NSString* sf;
@property(nonatomic,strong) NSArray* longForms;

@end
