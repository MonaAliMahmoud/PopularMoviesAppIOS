//
//  DetailsViewController.h
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/9/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"
#import "MovieDetails.h"
#import "HCSStarRatingView.h"
#import "YTPlayerView.h"
#import "VideosTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (weak, nonatomic) IBOutlet UIButton *favbtn;
@property (weak, nonatomic) IBOutlet UIView *rateview;

- (IBAction)addToFav:(id)sender;
- (IBAction)watchVideo:(id)sender;


@property NSMutableArray *reviews;
@property MovieDetails *myFavMovies;
@end

NS_ASSUME_NONNULL_END
