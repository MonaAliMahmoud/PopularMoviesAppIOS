//
//  MovieDetails.h
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/9/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import <Realm/RLMObjectBase.h>
#import <Realm/RLMThreadSafeReference.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetails : RLMObject

@property NSString *orginalTitle;
@property NSString *posterImg;
@property NSString *overview;
@property NSNumber <RLMFloat> *voteAverage;
@property NSString *releaseDate;
@property NSNumber <RLMInt> *movie_id;

@end

NS_ASSUME_NONNULL_END
