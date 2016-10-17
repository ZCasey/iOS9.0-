//
//  PhotoCollectionViewCell.m
//  相册多选
//
//  Created by sun on 16/6/23.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#define MAINWITH self.bounds.size.width;
@implementation PhotoCollectionViewCell
-(UIImageView *)photoImgV{
    if (_photoImgV == nil) {
        self.photoImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (375-15)/4, (375-15)/4)];
        self.photoImgV.backgroundColor = [UIColor blackColor];;
    }
    return _photoImgV;
}

-(UIImageView *)selectedImg{
    if (_selectedImg == nil) {
        self.selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake((375-15)/4 -30, 0, 30, 30)];
        self.selectedImg.image = [UIImage imageNamed:@"图层-2@2x"];
    }
    return _selectedImg;
}
-(UILabel *)isSelected{
    if (_isSelected == nil) {
        self.isSelected = [[UILabel alloc] initWithFrame:CGRectZero];
        self.isSelected.text = @"NO";
    }
    return _isSelected;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.photoImgV];
        [self.contentView addSubview:self.selectedImg];
        [self.contentView addSubview:self.isSelected];
    }
    return self;
}
@end
