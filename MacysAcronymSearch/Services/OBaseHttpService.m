//
//  OBaseHttpService.m
//  Contacts
//
//  Created by Niyaz on 10/30/15.
//  Copyright © 2015 Niyaz. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "OBaseHttpService.h"

@interface OBaseHttpService ()
@property(nonatomic,strong) AFHTTPSessionManager *sessionManager;
@end

@implementation OBaseHttpService

- (instancetype)initWithBaseURL:(NSURL *)baseURL {
    NSURLSessionConfiguration *sessionConfig = [[self class] buildSessionConfig];
    return [self initWithBaseURL:baseURL sessionConfiguration:sessionConfig];
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL
           sessionConfiguration:(NSURLSessionConfiguration *)urlSessionConfig {
    if(self = [super init]) {
        self.sessionConfiguration = urlSessionConfig;
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL
                                                     sessionConfiguration:self.sessionConfiguration];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }
    return self;
}


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(OHTTPServiceSuccessCallback)success
                      failure:(OHTTPServiceFailureCallback)failure {
    return [self.sessionManager GET:URLString
                         parameters:parameters
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                if (success) success(task, responseObject);
                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                if (failure) failure(task, error);
                            }];
}

+ (NSURLSessionConfiguration*) buildSessionConfig {
    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.allowsCellularAccess = NO;
    [sessionConfig setHTTPAdditionalHeaders:
     @{@"Content-Type": @"text/plain"}];
    sessionConfig.timeoutIntervalForRequest = 30.0;
    sessionConfig.timeoutIntervalForResource = 60.0;
    sessionConfig.HTTPMaximumConnectionsPerHost = 1;
    return sessionConfig;
}



@end
