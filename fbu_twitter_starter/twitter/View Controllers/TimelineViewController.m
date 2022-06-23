//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, tweetDelegate>

- (IBAction)didTapLogout:(id)sender;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)finishTweet:(Tweet *)tweet;
@end

@implementation TimelineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Need to describe datasource and delegate protocol in timeline vc interface definition
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchTweets];
    
    
    // Get timeline
    
}

-(void)finishTweet:(Tweet *)tweet{
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

-(void)fetchTweets{
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            
            self.arrayOfTweets =  [Tweet tweetsWithArray:tweets];
            
            for (Tweet *tweet in self.arrayOfTweets) {
                NSLog(@"%@", tweet.text);
                NSLog(@"%@", tweet.user.profilePicture);
            }
        NSLog(@"This is the number of tweeets: %d",[self.arrayOfTweets count]);
            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayOfTweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *tweet = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweetData = self.arrayOfTweets[indexPath.row];
    
    tweet.userName.text = tweetData.user.name;
    tweet.userHandle.text = tweetData.user.screenName;
    tweet.tweetDate.text = tweetData.createdAtString;
    tweet.tweetText.text = tweetData.text;
    NSString *rtCount = [NSString stringWithFormat:@"%i", tweetData.retweetCount];
    
    tweet.retweetCount.text = rtCount;
    
    NSString *faveCount = [NSString stringWithFormat:@"%i", tweetData.favoriteCount];
    
    tweet.favoriteCount.text = faveCount;
    
    NSString *URLString = tweetData.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    [tweet.profilePicture setImageWithURL:url];
    tweet.profilePicture.layer.borderColor = UIColor.blackColor.CGColor;
    tweet.profilePicture.layer.borderWidth = 2;
    
    tweet.tweet = tweetData;
    
    return tweet;
}
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

        // Create NSURL and NSURLRequest

    [self fetchTweets];
}

- (IBAction)didTapLogout:(id)sender {
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    
    //
    [[APIManager shared]logout];
}
@end
