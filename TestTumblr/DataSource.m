//
//  DataSource.m
//  TestTumblr
//
//  Created by Anton A on 17.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import "DataSource.h"

@interface DataSource()

@property (strong, nonatomic) NSMutableArray *picturesArray;
@property (assign, nonatomic) NSUInteger CurentTimeStamp;
@property (strong, nonatomic) NSString* checkString;
@end


@implementation DataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.picturesArray = [[NSMutableArray alloc]init];
    }
    return self;
}




- (void) loadPicturesWithTagAndTimeStamp:(NSString *)tag andTimeStamp:(NSUInteger)timeStamp{
    __block NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    [[APIManager sharedManager] loadDataWithParams:tag andTimeStamp:timeStamp completion:^(NSDictionary *dictionary, NSError *error) {
        if (!error) {
            NSArray *responseArray = [[NSArray alloc] initWithArray:dictionary[@"response"]];
            NSDictionary* dictionaryForCurentTimeStamp = [[NSDictionary alloc] initWithDictionary: [responseArray lastObject]];
            self.CurentTimeStamp = [dictionaryForCurentTimeStamp[@"timestamp"]integerValue];
            for (NSDictionary *blogsDictionary in responseArray){
                NSArray *photos = [[NSArray alloc]initWithArray:blogsDictionary[@"photos"]];
                for(NSDictionary *photosDictionary in photos){
                    NSDictionary *originalSize = [[NSDictionary alloc]initWithDictionary:photosDictionary[@"original_size"]];
                    Picture *picture = [[Picture alloc]initWithDictionary:originalSize];
                    [tempArr addObject:picture];
                }
            }
        }
        [self.picturesArray addObjectsFromArray:tempArr];
        if ([self.delegate respondsToSelector:@selector(reloadTable)]) {
            [self.delegate reloadTable];
        }
    }];
}

- (NSArray *)pictures {
    return [self.picturesArray copy];
}

- (NSUInteger) getCurrentTimeStamp{
    return self.CurentTimeStamp;
}

- (void) clearStorageForNewResponse{
    [self.picturesArray removeAllObjects];
}

@end
