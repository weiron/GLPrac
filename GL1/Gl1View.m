//
//  Gl1View.m
//  GLPrac
//
//  Created by Keisuke Matsumura on 2015/03/24.
//  Copyright (c) 2015年 Keisuke Matsumura. All rights reserved.
//

#import "Gl1View.h"
#import <OpenGL/gl3.h>

@implementation Gl1View

- (void)scene {
    glClearColor(0.2, 0.6, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
}

- (void)prepareOpenGL {
    [super prepareOpenGL];
    
    
}

@end
