//
//  CollectionReusableView.h
//  相册多选
//
//  Created by sun on 16/6/23.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableView : UICollectionReusableView
@property(nonatomic,strong)UILabel *title;
-(instancetype)initWithFrame:(CGRect)frame;
@end
