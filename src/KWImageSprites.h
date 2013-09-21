//
//  KWImageSprites.h
//  KWImageSprites
//
//  Created by Yusuke Kawasaki on 2013/09/17.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWImageSprites : NSObject

@property NSDictionary *map;
@property UIImage *image;

- (void)loadMapWithPath:(NSString *)path error:(NSError **)errorPtr;
- (void)loadMapWithURL:(NSURL *)url error:(NSError **)errorPtr;
- (void)loadImageWithPath:(NSString *)path error:(NSError **)errorPtr;
- (void)loadImageWithURL:(NSURL *)url error:(NSError **)errorPtr;

- (NSArray *)allNames;

- (UIImage *)spriteForName:(NSString *)name;
- (UIImage *)spriteForRect:(CGRect)rect;

@end
