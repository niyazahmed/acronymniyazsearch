//
//  AcronymSearchService.m
//  Contacts
//
//  Created by Niyaz on 10/30/15.
//  Copyright © 2015 Niyaz. All rights reserved.
//

#import "AcronymSearchService.h"
#import "UnknownServiceResponseError.h"
#import "AcronymMeanings.h"

#define acronymSearchEndPoint @"http://www.nactem.ac.uk/software/acromine"

@implementation AcronymSearchService

-(instancetype)init {
    return [super initWithBaseURL:[[self class] acronymSearchUrl]];
}

+(NSURL*) acronymSearchUrl {
    return [NSURL URLWithString:acronymSearchEndPoint];
}

- (void)fetchAcronymMeanings:(NSString*)searchText
                   onSuccess:(AcronymSearchSuccessCallback)onSuccess
                   onFailure:(AcronymSearchFailureCallback)onFailure {
    
    [self GET:[NSString stringWithFormat:@"dictionary.py?sf=%@",searchText]
   parameters:nil
      success:^(NSURLSessionDataTask *task, id response) {
          if ([response isKindOfClass:NSArray.class]) {
              if (onSuccess) {
                  onSuccess([self parseJson:(NSArray*)response]);
              }
          } else {
              if (onFailure) {
                  onFailure([[UnknownServiceResponseError alloc] initWithUnknownResponse:response]);
              }
          }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          if (onFailure) {
              NSLog(@"%@",error);
              onFailure(error);
          }
      }];

}

- (AcronymMeanings *)parseJson:(NSArray*)response {
    AcronymMeanings* meanings = [AcronymMeanings fromArray:response];
    return meanings;
}

@end
