//
//  FavouritesCollectionViewController.m
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/13/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import "FavouritesCollectionViewController.h"

@interface FavouritesCollectionViewController ()

@end

@implementation FavouritesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated{
   
    _favMovies =[MovieDetails allObjects];
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Favourites Movies";
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _favMovies.count;;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    if(_favMovies){
        
        NSString *url = @"http://image.tmdb.org/t/p/w185/";
        NSString *str =[[ _favMovies objectAtIndex:indexPath.row] posterImg];
        url = [url stringByAppendingString:str];
        NSLog(@"%@", str);
        UIImageView *movie = (UIImageView*)[cell viewWithTag:1];
        [movie sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"one"]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"datevc"];
    
    details.myFavMovies= [_favMovies objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:details animated:YES];
}

@end
