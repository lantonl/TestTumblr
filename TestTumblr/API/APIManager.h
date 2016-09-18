//
//  APIManager.h
//  TestTumblr
//
//  Created by Anton A on 17.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface APIManager : NSObject


+ (APIManager*) sharedManager;

- (void) loadDataWithParams:(NSString *)tag andTimeStamp:(NSUInteger) timestamp completion:(void(^)(NSDictionary *dictionary, NSError *error))completion;


@end
