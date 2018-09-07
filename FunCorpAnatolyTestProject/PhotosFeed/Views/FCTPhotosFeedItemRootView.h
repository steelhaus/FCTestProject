//
//  FCTPhotosFeedRootView.h
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCTPhotosFeedItemRootView : UIView <UIWebViewDelegate>

- (void)setVkUrl:(NSURL *_Nullable)url;
- (void)setAdUrl:(NSURL *_Nullable)url;

@end
