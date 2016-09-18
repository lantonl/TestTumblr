//
//  Picture.m
//  TestTumblr
//
//  Created by Anton A on 17.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import "Picture.h"
#import <UIKit/UIKit.h>

@interface Picture ()

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat heightAfterResize;


@end


@implementation Picture

- (instancetype) initWithDictionary:(NSDictionary *)data {
    if (self) {
        self.pictureUrl = [NSURL URLWithString:data[@"url"]];
        self.height = [data[@"height"]floatValue];
        self.width = [data[@"width"]floatValue];
        [self calculateResizeHeight];
    }
    return self;
}

- (void) calculateResizeHeight {
    CGFloat actualHeight = self.height;
    CGFloat actualWidth = self.width;
    CGFloat ratio = 300/actualWidth;
    self.heightAfterResize = actualHeight*ratio;
}

- (CGFloat) heightForCell{
    return self.heightAfterResize;
}
@end
