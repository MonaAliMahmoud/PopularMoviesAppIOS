//
//  MoviesCollectionViewController.m
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/8/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import "MoviesCollectionViewController.h"

@interface MoviesCollectionViewController ()

@end

@implementation MoviesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *link = @"https://api.themoviedb.org/3/movie/popular?api_key=658680e409a5e9e11988f3e49361edae";
   
    _movies = [NSMutableArray new];
    [self requestConnection: link];

    self.title = @"Popular Movies";
}

- (void)requestConnection:(NSString*) link{

        NSURL *url = [NSURL URLWithString:link];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
        AFHTTPRequestOperation *conn = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        conn.responseSerializer = [AFJSONResponseSerializer  serializer];
        
        [conn setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *co, id responseObject) {
            
            NSArray* arr1 = [responseObject objectForKey:@"results"];
            for (int i = 0; i < arr1.count; i++) {
                [self->_movies addObject: arr1[i]];
            }
            
            printf("request success");
            [self.collectionView reloadData];
            
        } failure:^(AFHTTPRequestOperation *conn, NSError *error) {
            printf("request failed");
        }];
        
        [conn start];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _movies.count;;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    if(_movies){
        
        NSDictionary *dic = _movies[indexPath.row];
        NSString *url = @"http://image.tmdb.org/t/p/w185/";
        NSString *str = [dic objectForKey:@"poster_path"];
        url = [url stringByAppendingString:str];
        UIImageView *movie = (UIImageView*)[cell viewWithTag:1];
        [movie sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"one"]];
        
        if(indexPath.row == _movies.count-1){
        
            NSString *link = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?api_key=658680e409a5e9e11988f3e49361edae&page=%lu", _movies.count / 20+1];
            [self requestConnection:link];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"datevc"];

    MovieDetails *temp = [MovieDetails new];
    temp.orginalTitle = _movies[indexPath.row][@"title"];
    [temp setOverview: _movies[indexPath.row][@"overview"]];
    [temp setVoteAverage: _movies[indexPath.row][@"vote_average"]];
    [temp setReleaseDate: _movies[indexPath.row][@"release_date"]];
    [temp setPosterImg:_movies[indexPath.row][@"poster_path"]];
    [temp setMovie_id: _movies[indexPath.row][@"id"]];

    details.myFavMovies=temp;
    
    [self.navigationController pushViewController:details animated:YES];
}

@end
