//
//  CVUMoviePlayerView.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 23.02.13.
//  MIT LICENSE
//

#import <MediaPlayer/MediaPlayer.h>
#import "CVUMoviePlayerView.h"

@interface CVUMoviePlayerView ()
@property(nonatomic, strong, readwrite) UIView* placeholderView;
@property(nonatomic, strong, readwrite) UIImageView* placeholderImageView;
@property(nonatomic, strong, readwrite) UIButton* placeholderPlayVideoButton;
@property(nonatomic, strong, readwrite) MPMoviePlayerController* moviePlayerController;
@property(nonatomic, copy, readwrite) NSURL* videoURL;
@end

@implementation CVUMoviePlayerView

#pragma mark - lifecycle
- (id)initWithFrame:(CGRect)frame placeholderImage:(UIImage*)placeholderImage videoURL:(NSURL*)videoURL {
    self = [super initWithFrame:frame];
    if (self) {
        _videoURL = videoURL;
        
        [self initVideoPlayerPlaceholderViewWithFrame:frame placeholderImage:placeholderImage];
        [self addSubview:_placeholderView];
        
        // Setup the player controller and add it's view as a subview:
        [self initMoviePlayerControllerWithFrame:frame videoURL:videoURL];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame videoURL:(NSURL*)videoURL {
    self = [self initWithFrame:frame placeholderImage:nil  videoURL:videoURL];
    return self;
}

- (id)initWithFrame:(CGRect)frame placeholderImage:(UIImage*)placeholderImage {
    self = [self initWithFrame:frame placeholderImage:placeholderImage videoURL:nil];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame placeholderImage:nil videoURL:nil];
    return self;
}

- (void)initMoviePlayerControllerWithFrame:(CGRect)frame videoURL:(NSURL*)videoURL {
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayerController.view.frame = CGRectMake(0.0f, 0.0f, 200.0f, 200.0f);
    self.moviePlayerController.view.center = self.center;
}

#pragma mark - setters
- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    self.placeholderImageView.image = placeholderImage;
    _placeholderImage = placeholderImage;
}

#pragma mark - private view setup methods
- (void)initVideoPlayerPlaceholderViewWithFrame:(CGRect)frame
                               placeholderImage:(UIImage*)placeholderImage {
    CGRect placeholderViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _placeholderView = [[UIView alloc] initWithFrame:placeholderViewFrame];
    _placeholderView.backgroundColor = [UIColor greenColor];
    
    CGRect placeholderImageViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _placeholderImageView = [[UIImageView alloc] initWithFrame:placeholderImageViewFrame];
    _placeholderImageView.image = placeholderImage;
    _placeholderImageView.backgroundColor = [UIColor clearColor];
    [_placeholderView addSubview:_placeholderImageView];
    
    CGSize playButtonSize = CGSizeMake(50, 50);
    CGRect playButtonFrame = CGRectMake((frame.size.width - playButtonSize.width) / 2, (frame.size.height - playButtonSize.height) / 2, playButtonSize.width , playButtonSize.height ) ;
    _placeholderPlayVideoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _placeholderPlayVideoButton.frame = playButtonFrame;
    [_placeholderPlayVideoButton addTarget:self action:@selector(didPushVideoPlayButton:) forControlEvents:UIControlEventTouchDown];
    [_placeholderView addSubview:_placeholderPlayVideoButton];
}

#pragma mark - respond to actions
- (void)didPushVideoPlayButton:(id)sender {    
    [self addSubview:self.moviePlayerController.view];
    [self.moviePlayerController play];
}

@end
