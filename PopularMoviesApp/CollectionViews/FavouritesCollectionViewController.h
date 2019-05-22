//
//  FavouritesCollectionViewController.h
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/13/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"
#import "DetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavouritesCollectionViewController : UICollectionViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property RLMResults *favMovies;
@property NSMutableData *receivedData;

@end

NS_ASSUME_NONNULL_END
