//
//  CVUMoviePlayerView.m
//
//  Copyright (c) 2013 Claudiu-Vlad Ursache (http://www.cvursache.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "CVUMoviePlayerView.h"

NSString * const CVUMoviePlayerViewDidShowLoadingStateLabel = @"CVUMoviePlayerViewDidShowLoadingStateLabelNotification";

@interface CVUMoviePlayerView ()
@property(nonatomic, strong, readwrite) UILabel* loadingStateLabel;
@property(nonatomic, strong, readwrite) UIView* placeholderView;
@property(nonatomic, strong, readwrite) UIImageView* placeholderImageView;
@property(nonatomic, strong, readwrite) UIButton* placeholderPlayVideoButton;
@property(nonatomic, strong, readwrite) MPMoviePlayerController* moviePlayerController;
@property(nonatomic, copy, readwrite) NSURL* videoURL;
@end

@implementation CVUMoviePlayerView

#pragma mark - lifecycle init
- (id)initWithFrame:(CGRect)frame placeholderImage:(UIImage*)placeholderImage videoURL:(NSURL*)videoURL playButtonImage:(UIImage*)playButtonImage {
    self = [super initWithFrame:frame];
    if (self) {
        _videoURL = videoURL;
        
        [self initVideoPlayerPlaceholderViewWithFrame:frame placeholderImage:placeholderImage playButtonImage:playButtonImage];
        [self addSubview:_placeholderView];
        
        // Setup the player controller and add its view as a subview:
        [self initMoviePlayerControllerWithFrame:frame videoURL:videoURL];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame placeholderImage:(UIImage*)placeholderImage videoURL:(NSURL*)videoURL {
    self = [self initWithFrame:frame placeholderImage:nil videoURL:videoURL playButtonImage:nil];
    return self;
}

- (id)initWithFrame:(CGRect)frame videoURL:(NSURL*)videoURL {
    self = [self initWithFrame:frame placeholderImage:nil videoURL:videoURL playButtonImage:nil];
    return self;
}

- (id)initWithFrame:(CGRect)frame placeholderImage:(UIImage*)placeholderImage {
    self = [self initWithFrame:frame placeholderImage:placeholderImage videoURL:nil playButtonImage:nil];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame placeholderImage:nil videoURL:nil playButtonImage:nil];
    return self;
}

- (void)initMoviePlayerControllerWithFrame:(CGRect)frame videoURL:(NSURL*)videoURL {
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayerController.view.frame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
    self.moviePlayerController.view.center = self.center;
}

#pragma mark - lifecycle dealloc
- (void)dealloc {
    [self cleanupMoviePlayerControllerInstance];
}

- (void)cleanupMoviePlayerControllerInstance {
    [self pauseVideo];
    [self deregisterForNotificationsFromMoviePlayer:self.moviePlayerController];
    [self.moviePlayerController.view removeFromSuperview];
    self.moviePlayerController = nil;
}

#pragma mark - setters
- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    self.placeholderImageView.image = placeholderImage;
    _placeholderImage = placeholderImage;
}

#pragma mark - private view setup methods
- (void)initVideoPlayerPlaceholderViewWithFrame:(CGRect)frame
                               placeholderImage:(UIImage*)placeholderImage
                                playButtonImage:(UIImage*)playButtonImage {
    CGRect placeholderViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _placeholderView = [[UIView alloc] initWithFrame:placeholderViewFrame];
    
    CGRect placeholderImageViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _placeholderImageView = [[UIImageView alloc] initWithFrame:placeholderImageViewFrame];
    _placeholderImageView.image = placeholderImage;
    [_placeholderView addSubview:_placeholderImageView];
    
    CGSize playButtonSize = CGSizeMake(50, 50);
    CGRect playButtonFrame = CGRectMake((frame.size.width - playButtonSize.width) / 2, (frame.size.height - playButtonSize.height) / 2, playButtonSize.width , playButtonSize.height ) ;
    _placeholderPlayVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _placeholderPlayVideoButton.frame = playButtonFrame;
    [_placeholderPlayVideoButton addTarget:self action:@selector(didPushVideoPlayButton:) forControlEvents:UIControlEventTouchDown];
    [_placeholderPlayVideoButton setImage:playButtonImage forState:UIControlStateNormal];
    [_placeholderView addSubview:_placeholderPlayVideoButton];
    
    CGSize loadingStateLabelSize = CGSizeMake(CGRectGetWidth(placeholderImageViewFrame), 20.0f);
    CGRect loadingStateFrame = CGRectMake(CGRectGetMinX(placeholderImageViewFrame), (frame.size.height - loadingStateLabelSize.height) / 2, loadingStateLabelSize.width, loadingStateLabelSize.height);
    self.loadingStateLabel = [[UILabel alloc] initWithFrame:loadingStateFrame];
    self.loadingStateLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - respond to actions
- (void)didPushVideoPlayButton:(id)sender {
    self.moviePlayerController.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.moviePlayerController.view];
    [self playVideo];
}

#pragma mark - loading state label


#pragma mark - video actions
- (void)playVideo {
    [self registerForNotificationsFromMoviePlayer:self.moviePlayerController];
    [self.moviePlayerController play];
    [self addSubview:self.loadingStateLabel];
}

- (void)pauseVideo {
    [self.moviePlayerController pause];
}


#pragma mark - autorotation

-(void)registerForNotificationsFromMoviePlayer:(MPMoviePlayerController*)moviePlayer {
    if (nil == moviePlayer) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notification_moviePlayerLoadStateDidChange:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notification_moviePlayerPlaybackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:moviePlayer];
}

-(void)deregisterForNotificationsFromMoviePlayer:(MPMoviePlayerController*)moviePlayer {
    if (nil == moviePlayer) {
        return;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:moviePlayer];
}

- (void)notification_moviePlayerLoadStateDidChange:(NSNotification*)notification {
    MPMoviePlayerController* moviePlayer = notification.object;
    MPMovieLoadState loadState = moviePlayer.loadState;
    
    BOOL isMoviePlayable = (loadState == (MPMovieLoadStatePlaythroughOK|MPMovieLoadStatePlayable));
    NSString* moviePlayerLoadStateText = [self labelTextForMoviePlayerLoadState:loadState];
    if (isMoviePlayable) {
        [self.loadingStateLabel removeFromSuperview];
    }
}

- (void)notification_moviePlayerPlaybackStateDidChange:(NSNotification*)notification {
    MPMoviePlayerController* moviePlayer = notification.object;
    MPMoviePlaybackState playbackState = moviePlayer.playbackState;
    MPMovieLoadState loadState = moviePlayer.loadState;
    
    BOOL isMoviePlayable = (loadState == (MPMovieLoadStatePlaythroughOK|MPMovieLoadStatePlayable));
    if (NO == isMoviePlayable && (playbackState == MPMoviePlaybackStatePlaying)) {
        [self addSubview:self.loadingStateLabel];
        [[NSNotificationCenter defaultCenter] postNotificationName:CVUMoviePlayerViewDidShowLoadingStateLabel object:self];
    }
}

- (NSString*)labelTextForMoviePlayerLoadState:(MPMovieLoadState)loadState {
    return @"loading";
}

@end
