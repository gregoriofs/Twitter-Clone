//
//  ComposeViewController.h
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol tweetDelegate <NSObject>

- (void)finishTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) id<tweetDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;

@end



NS_ASSUME_NONNULL_END
