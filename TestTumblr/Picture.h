//
//  Picture.h
//  TestTumblr
//
//  Created by Anton A on 17.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Picture : NSObject

@property (strong, nonatomic) NSURL *pictureUrl;


- (instancetype) initWithDictionary:(NSDictionary *)data;
- (CGFloat) heightForCell;

@end
