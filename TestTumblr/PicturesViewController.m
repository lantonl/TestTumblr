//
//  PicturesViewController.m
//  TestTumblr
//
//  Created by Anton A on 17.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import "PicturesViewController.h"
#import "DataSource.h"
#import "Picture.h"
#import "CustomCell.h"
#import "UIImage+ResizeImage.h"
#import "FullSizeImageViewController.h"

static NSString*kCellIdentifier = @"CustomCell";
static NSString*kShowFullSizeImage = @"ShowFullSizeImageSegue";

@interface PicturesViewController () <DataSourceDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DataSource *dataSource;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) NSString   *searchString;
@property (assign, nonatomic) BOOL buttonSearchDidTouchCheck;
@property (strong, nonatomic) UIImage *currentImage;
@end

@implementation PicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.tableView setSeparatorStyle:NO];
    self.dataSource = [[DataSource alloc]init];
    self.dataSource.delegate = self;
    self.buttonSearchDidTouchCheck = NO;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIImage *image = cell.originalImage;    
    [self performSegueWithIdentifier:kShowFullSizeImage sender:image];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger counter = [[self.dataSource pictures ]count];
    if (indexPath.row == counter - 1){
        [self.dataSource loadPicturesWithTagAndTimeStamp:self.searchString andTimeStamp:[self.dataSource getCurrentTimeStamp]];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = [[self.dataSource pictures] count];
    return count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Picture* picture = [[self.dataSource pictures]objectAtIndex:indexPath.row];
    return [picture heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell  = [tableView dequeueReusableCellWithIdentifier:                                 kCellIdentifier forIndexPath:indexPath];
    Picture* picture = [[self.dataSource pictures]objectAtIndex:indexPath.row];
    cell.pictureImageView.image = [UIImage imageNamed:@"placeholder.png"];
    NSURL *url = picture.pictureUrl;
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CustomCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.originalImage = image;
                        updateCell.pictureImageView.image = [image resizeImage];
                });
            }
        }
    }];
    [task resume];
    return cell;
}


#pragma mark - DataSourceDelegate

- (void) reloadTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.buttonSearchDidTouchCheck){
            NSIndexPath *indexPathFirstCell = [NSIndexPath indexPathForRow:0 inSection:0];
            NSArray* array = [[NSArray alloc] initWithArray:self.tableView.indexPathsForVisibleRows];
            if ([array firstObject]){
                [self.tableView scrollToRowAtIndexPath:indexPathFirstCell atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }
        self.buttonSearchDidTouchCheck = NO;
        [self.tableView reloadData];
    });
}

#pragma mark - ButtonAction

- (IBAction)didTouchSearchButton:(id)sender {
        [self.view endEditing:YES];
        if(![self.searchTextField.text isEqualToString:@""]){
        self.buttonSearchDidTouchCheck = YES;
        [self.dataSource clearStorageForNewResponse];
        self.searchString = self.searchTextField.text;
        [self.dataSource loadPicturesWithTagAndTimeStamp:self.searchString andTimeStamp:[[NSDate date] timeIntervalSince1970]];
        } else {
            self.searchTextField.placeholder = @"please type something";
        }
}

- (IBAction)dismissTextField:(id)sender {
        [self.searchTextField resignFirstResponder];
        [self.view endEditing:YES];
        if(![self.searchTextField.text isEqualToString:@""]){
            self.buttonSearchDidTouchCheck = YES;
            [self.dataSource clearStorageForNewResponse];
            self.searchString = self.searchTextField.text;
            [self.dataSource loadPicturesWithTagAndTimeStamp:self.searchString andTimeStamp:[[NSDate date] timeIntervalSince1970]];
        } else {
            self.searchTextField.placeholder = @"please type something";
        }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        FullSizeImageViewController *viewController = segue.destinationViewController;
        viewController.picture = sender;
}

@end
