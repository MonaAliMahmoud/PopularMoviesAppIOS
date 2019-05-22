//
//  VideosTableViewController.h
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/15/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideosTableViewController : UITableViewController

@property NSString *movieID;
@property NSDictionary *dicTrailors;
@property NSMutableArray *trailors;
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

-(void) requestConnection:(NSString*) link;

@end

NS_ASSUME_NONNULL_END
