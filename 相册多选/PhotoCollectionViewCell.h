//
//  PhotoCollectionViewCell.h
//  相册多选
//
//  Created by sun on 16/6/23.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *photoImgV;
@property(nonatomic,strong)UIImageView *selectedImg;
@property(nonatomic,strong)UILabel *isSelected;
-(instancetype)initWithFrame:(CGRect)frame;
@end
