//
//  VideosTableViewController.m
//  PopularMoviesApp
//
//  Created by Mona Ali on 4/15/19.
//  Copyright © 2019 Mona Ali. All rights reserved.
//

#import "VideosTableViewController.h"

@interface VideosTableViewController ()

@end

@implementation VideosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_movieID);
    [self.playerView loadWithVideoId:_movieID];
    
    self.title =@"Trailors";
    
    NSString * trailorsLink= [[NSString alloc] initWithString:[@"https://api.themoviedb.org/3/movie/" stringByAppendingString:_movieID]];
    
    [self requestConnection:trailorsLink];
}

- (void)requestConnection:(NSString *)link{
    
    NSURL *url = [NSURL URLWithString: [link stringByAppendingString:@"/videos?api_key=658680e409a5e9e11988f3e49361edae"] ];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *conn=[[AFHTTPRequestOperation alloc] initWithRequest:request1];
    conn.responseSerializer=[AFJSONResponseSerializer serializer];
    [conn setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * operation1, id  responseObject){
        
        _dicTrailors =(NSDictionary*)responseObject;
        _trailors=[_dicTrailors objectForKey:@"results"];

        [self.tableView reloadData];
        
        printf("request success");
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        printf("request failed");
    }];
    
    [conn start];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _trailors.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
     //Configure the cell...
    YTPlayerView* playerView = (YTPlayerView*)[cell viewWithTag:1];
    [playerView loadWithVideoId:_trailors[indexPath.row][@"key"]];
    
    return cell;
}

@end
