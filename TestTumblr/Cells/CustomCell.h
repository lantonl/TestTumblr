//
//  CustomCell.h
//  TestTumblr
//
//  Created by Anton A on 18.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (strong, nonatomic) UIImage *originalImage;




@end
