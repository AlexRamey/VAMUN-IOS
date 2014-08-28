//
//  VAMWebViewController.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMContentViewController.h"

@interface VAMWebViewController : VAMContentViewController <UIWebViewDelegate, UIGestureRecognizerDelegate>
{
    int loadStack;
}

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@end
