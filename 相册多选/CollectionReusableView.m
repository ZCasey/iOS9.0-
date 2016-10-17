//
//  CollectionReusableView.m
//  相册多选
//
//  Created by sun on 16/6/23.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView
-(UILabel *)title{
    if (_title == nil) {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-60, 10, 50, 20)];
    }
    return _title;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor redColor];
    if (self) {
        [self addSubview:self.title];
    }
    return self;
}
@end
