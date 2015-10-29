//
//  OBaseHttpService.h
//  Contacts
//
//  Created by Niyaz on 10/30/15.
//  Copyright © 2015 Niyaz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OHTTPServiceSuccessCallback)(NSURLSessionDataTask *task, id responseObject);
typedef void (^OHTTPServiceFailureCallback)(NSURLSessionDataTask *task, NSError *error);

@interface OBaseHttpService : NSObject

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;

/*
 Returns default session configured for caching and timeout.  Extend or override as the service needs
 */
+ (NSURLSessionConfiguration *)buildSessionConfig;

- (instancetype)initWithBaseURL:(NSURL *)baseURL;
- (instancetype)initWithBaseURL:(NSURL *)baseURL sessionConfiguration:(NSURLSessionConfiguration *)urlSessionConfig;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(OHTTPServiceSuccessCallback)success
                      failure:(OHTTPServiceFailureCallback)failure;

@end
