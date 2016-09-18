//
//  APIManager.m
//  TestTumblr
//
//  Created by Anton A on 17.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import "APIManager.h"


static NSString *kBaseURL = @"http://api.tumblr.com/v2/tagged?tag=";
static NSString *kApiKey  = @"&limit=20&api_key=CcEqqSrYdQ5qTHFWssSMof4tPZ89sfx6AXYNQ4eoXHMgPJE03U";




@implementation APIManager



+ (APIManager*) sharedManager{
    
    static APIManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[APIManager alloc] init];
    });
    return _sharedManager;
}

- (void) loadDataWithParams:(NSString *)tag andTimeStamp:(NSUInteger)timeStamp completion:(void(^)(NSDictionary *dictionary, NSError *error))completion {
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@&before=%ld%@", kBaseURL, tag, timeStamp, kApiKey]];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:5.0];
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            completion(nil, error);
            NSLog(@"LOAD DATA ERROR!!!");
        } else {
            NSError* parseError = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (parseError != nil){
                completion(nil, parseError);
            } else {
                completion(dictionary, nil);
            };
        }
    }];
    [task resume];
    
}



@end
