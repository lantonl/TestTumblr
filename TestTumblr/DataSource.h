//
//  DataSource.h
//  TestTumblr
//
//  Created by Anton A on 17.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"
#import "Picture.h"

@protocol DataSourceDelegate <NSObject>

- (void) reloadTable;


@end



@interface DataSource : NSObject

@property (nonatomic, weak) id<DataSourceDelegate> delegate;

- (NSArray*) pictures;
- (NSUInteger) getCurrentTimeStamp;
- (void) clearStorageForNewResponse;
- (void) loadPicturesWithTagAndTimeStamp:(NSString *)tag andTimeStamp:(NSUInteger)timeStamp;




@end
