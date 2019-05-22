//
//  DetailsViewController.m
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/9/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property bool fav;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fav=false;
    [_scrollview setContentSize:CGSizeMake(0, 1200)];
    
    [_titleLabel setText:_myFavMovies.orginalTitle];
    [_voteLabel setText:[NSString stringWithFormat:@"%@",_myFavMovies.voteAverage]];
    [_overviewLabel setText:_myFavMovies.overview];
    [_dateLabel setText:_myFavMovies.releaseDate];
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0,0, 200, 50)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    
    starRatingView.value =([_myFavMovies.voteAverage doubleValue] *0.5);
    
    starRatingView.tintColor = [UIColor redColor];
    starRatingView.allowsHalfStars = YES;
    starRatingView.accurateHalfStars = YES;
    starRatingView.tintColor= [UIColor redColor];
    
    [self.rateview setUserInteractionEnabled:NO];
    [self.rateview addSubview:starRatingView];
    
    [self isFav:_myFavMovies.movie_id];
    
    NSString *url = @"http://image.tmdb.org/t/p/w185/";
    url = [url stringByAppendingString:_myFavMovies.posterImg];
    [_poster sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"one"]];
    
    int id = [_myFavMovies.movie_id intValue];
    printf("Movie id = %d", id);

    NSString *reviewlink = [NSString stringWithFormat: @"https://api.themoviedb.org/3/movie/%d/reviews?api_key=658680e409a5e9e11988f3e49361edae", id];
    
    _reviews = [NSMutableArray new];
    [self requestReviews: reviewlink];
    
    [_myTable setDelegate:self];
    [_myTable setDataSource:self];
}

- (void)requestReviews:(NSString*) reviewlink{
    
    NSURL *url = [NSURL URLWithString:reviewlink];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *conn = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    conn.responseSerializer = [AFJSONResponseSerializer  serializer];
    
    [conn setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *co, id responseObject) {
        
        NSArray* arr1 = [responseObject objectForKey:@"results"];
        for (int i = 0; i < arr1.count; i++) {
            [self->_reviews addObject: arr1[i]];
        }
        
        printf("request success");
        [self.myTable reloadData];
        
    } failure:^(AFHTTPRequestOperation *conn, NSError *error) {
        printf("request failed");
    }];
    
    [conn start];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"";
    int index = 0;
    
    index = indexPath.row % 2;
    
    if (index == 0) {
        
        cellIdentifier = @"cellOne";
    }else{
        
        cellIdentifier = @"cellTwo";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *authorLabel;
    UILabel *author;
    UITextView *content;
    
    if (index == 0) {
        authorLabel = (UILabel*)[cell viewWithTag:1];
        author= (UILabel*)[cell viewWithTag:2];
        
        [author setText: _reviews[indexPath.row][@"author"]];
    }
    else{
        content = (UITextView*)[cell viewWithTag:3];
        [content setText: _reviews[indexPath.row][@"content"]];
    }
    return cell;
}

- (IBAction)addToFav:(id)sender {
   
    if(!_fav){
        _fav = true;
        UIButton *btn = (UIButton *)sender;
        [btn setImage:[UIImage imageNamed:@"redheart"] forState:UIControlStateNormal];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject: _myFavMovies];
        [realm commitWriteTransaction];
    }
    else{
        _fav = false;
        [self deleteMov:_myFavMovies.movie_id];
        
    }
}

-(void)isFav:(NSNumber*)movId{
    RLMResults<MovieDetails *> *myFav ;
    // Query using an NSPredicate
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"movie_id = %@",
                         movId];
    myFav = [MovieDetails objectsWithPredicate:pred];
    if(myFav.count!=0){
        _fav=true;
        [_favbtn setImage:[UIImage imageNamed:@"redheart"] forState:UIControlStateNormal];
    }
}

-(void)deleteMov:(NSNumber*)movId{
    RLMResults<MovieDetails *> *myFav ;
    // Query using an NSPredicate
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"movie_id = %@",
                         movId];
    myFav = [MovieDetails objectsWithPredicate:pred];
    RLMRealm *realm = [RLMRealm defaultRealm];

    if(myFav.count!=0){
        [realm beginWriteTransaction];
        [realm deleteObject:[myFav firstObject]];
        [realm commitWriteTransaction];
        [_favbtn setImage:[UIImage imageNamed:@"emptyheart"] forState:UIControlStateNormal];
    }
}

- (IBAction)watchVideo:(id)sender {
    
    VideosTableViewController *videovc =[self.storyboard instantiateViewControllerWithIdentifier:@"videovc"];
    [videovc setMovieID:[_myFavMovies.movie_id stringValue]];
    [self.navigationController pushViewController:videovc animated:YES];
}

@end
