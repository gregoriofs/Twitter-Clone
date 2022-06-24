//
//  TweetDetailViewController.h
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN


@protocol reloadDelegate <NSObject>

-(void)finishedDetails:(NSIndexPath*)currentTweet;

@end

@interface TweetDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userHandle;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (strong, nonatomic) Tweet *tweet;
@property (assign,nonatomic) NSIndexPath *currTweetPath;
@property (weak, nonatomic) id<reloadDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
