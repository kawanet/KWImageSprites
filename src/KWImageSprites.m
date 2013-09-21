//
//  KWImageSprites.m
//  KWImageSprites
//
//  Created by Yusuke Kawasaki on 2013/09/17.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "KWImageSprites.h"

@implementation KWImageSprites

NSMutableDictionary *_cache;

- (void)loadMapWithPath:(NSString *)name error:(NSError **)errorPtr {
    NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
    NSURL *url = [NSURL URLWithString:name relativeToURL:resourceURL];
    [self loadMapWithURL:url error:errorPtr];
}

- (void)loadMapWithURL:(NSURL *)url error:(NSError **)errorPtr {
    NSError *err = nil;
    NSData *json = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&err];
    if (err) {
        *errorPtr = err;
        return;
    }
    
    self.map = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        *errorPtr = err;
        return ;
    }
}

- (void)loadImageWithPath:(NSString *)name error:(NSError **)errorPtr {
    NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
    NSURL *url = [NSURL URLWithString:name relativeToURL:resourceURL];
    [self loadImageWithURL:url error:errorPtr];
}

- (void)loadImageWithURL:(NSURL *)url error:(NSError **)errorPtr {
    NSError *err = nil;
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&err];
    if (err) {
        *errorPtr = err;
    }
    
    self.image = [UIImage imageWithData:data];
}

- (UIImage *)spriteForName:(NSString *)name {
    NSArray *array = self.map[name];
    if (!array || array.count < 4) {
        return nil;
    }
    
    CGFloat x = ((NSNumber *) (array[0])).floatValue;
    CGFloat y = ((NSNumber *) (array[1])).floatValue;
    CGFloat w = ((NSNumber *) (array[2])).floatValue;
    CGFloat h = ((NSNumber *) (array[3])).floatValue;
    CGRect rect = CGRectMake(x, y, w, h);
    
    UIImage *sprite = [self spriteForRect:rect];
    return sprite;
}

- (UIImage *)spriteForRect:(CGRect)rect {
    // create empty dictionary if not found
    if (!_cache) {
        _cache = [NSMutableDictionary dictionary];
    }
    
    // cache name by rectangle
    NSString *name = [NSString stringWithFormat:@"x=%.0f&y=%.0f&w=%.0f&h=%.0f",
                      rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
    
    // check cached
    UIImage *cache = _cache[name];
    if (cache) {
        return cache;
    }
    
    // clip an image
    CGImageRef cgimage = CGImageCreateWithImageInRect(self.image.CGImage, rect);
    UIImage *sprite = [UIImage imageWithCGImage:cgimage];
    CGImageRelease(cgimage);

    // cache result
    _cache[name] = sprite;
    return sprite;
}

@end
