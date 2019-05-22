//
//  MoviesCollectionViewController.h
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/8/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"
#import "DetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoviesCollectionViewController : UICollectionViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property NSMutableData *receivedData;
@property NSMutableArray *movies;

-(void) requestConnection:(NSString*) link;

@end

NS_ASSUME_NONNULL_END
