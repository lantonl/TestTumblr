//
//  FullSizeImageViewController.m
//  TestTumblr
//
//  Created by Anton A on 18.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import "FullSizeImageViewController.h"

@interface FullSizeImageViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *fullSizeImageView;

@end

@implementation FullSizeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tumblrNavigation.png"]];
    self.fullSizeImageView.image = self.picture;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController) {
    self.navigationController.navigationBarHidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
