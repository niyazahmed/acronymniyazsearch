//
//  AcronymSearchService.h
//  Contacts
//
//  Created by Niyaz on 10/30/15.
//  Copyright © 2015 Niyaz. All rights reserved.
//

#import "OBaseHttpService.h"
@class AcronymMeanings;

typedef void (^AcronymSearchSuccessCallback)(AcronymMeanings *response);
typedef void (^AcronymSearchFailureCallback)(NSError *error);

@interface AcronymSearchService : OBaseHttpService

- (void)fetchAcronymMeanings:(NSString*)searchText
                   onSuccess:(AcronymSearchSuccessCallback)onSuccess
                   onFailure:(AcronymSearchFailureCallback)onFailure;
@end
