//
//  AcronymLongForm.h
//  MacysAcronymSearch
//
//  Created by Niyaz Ahmed on 10/30/15.
//  Copyright (c) 2015 Niyaz Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jsonizer.h"

@interface AcronymLongForm : NSObject<Jsonizer,NSCopying>

@property(nonatomic,strong) NSString* lf;
@property(nonatomic,strong) NSNumber* freq;
@property(nonatomic,strong) NSNumber* since;

@end
