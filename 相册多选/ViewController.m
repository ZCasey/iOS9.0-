//
//  ViewController.m
//  相册多选
//
//  Created by sun on 16/6/23.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "ZLPhotoTool.h"
#import "PhotoCollectionViewCell.h"
#import "CollectionReusableView.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)NSMutableArray *assetArr;
@property(nonatomic,strong)NSMutableArray<ZLPhotoAblumList *> *photoAblumListArr;//相册集数组
@property(nonatomic,strong)NSMutableArray <UIImage *>*imagesArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assetArr = [@[] mutableCopy];
    self.imagesArr = [@[] mutableCopy];
    self.photoAblumListArr = [@[] mutableCopy];
    [self setInterface];
    [self getAllPicsFromLocalPhone];
    [self getaAssetCollection];
    UIImage *image=[UIImage imageNamed:@"雪花"];
    [image drawAtPoint:CGPointMake(0, 1)];
    
}

#pragma mark - 界面的初始化
-(void)setInterface{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.view.bounds.size.width-15)/4, (self.view.bounds.size.width-15)/4);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 30);
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.allowsMultipleSelection = NO;
    
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    /*
        用于表头，表尾的视图注册
     */
    [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    //[self.view addSubview:self.collectionView];
    
    
    //滚动视图的注册(用于滚动集合视图)
    self.scrollerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollerView.showsVerticalScrollIndicator = YES;
    self.scrollerView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*2);
    [self.scrollerView addSubview:self.collectionView];
    [self.view addSubview:self.scrollerView];
    
}

#pragma mark -从本机相册中获取所有照片
-(void)getAllPicsFromLocalPhone{
    ZLPhotoTool *tool = [ZLPhotoTool new];
    NSArray<PHAsset *> * arr =  [tool getAllAssetInPhotoAblumWithAscending:YES];
    [_assetArr addObjectsFromArray:arr];
}


#pragma mark - 获取相册集
-(void)getaAssetCollection{
    /*
     @interface ZLPhotoAblumList : NSObject
     
     @property (nonatomic, copy) NSString *title; //相册名字
     @property (nonatomic, assign) NSInteger count; //该相册内相片数量
     @property (nonatomic, strong) PHAsset *headImageAsset; //相册第一张图片缩略图
     @property (nonatomic, strong) PHAssetCollection *assetCollection; //相册集，通过该属性获取该相册集下所有照片
     
     photoAblumListArr用来存放 ZLPhotoAblumList类的数组
     */
    
    NSArray * modelArr = [[ZLPhotoTool sharePhotoTool] getPhotoAblumList];
    [self.photoAblumListArr addObjectsFromArray:modelArr];
}


#pragma mark 集合视图的代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.photoAblumListArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //在此相册组下的照片数量（它的属性看上面）
    ZLPhotoAblumList *model =self.photoAblumListArr[section];
    return model.count;
}

/*
    添加组头视图的
 */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZLPhotoAblumList *photoAblum = _photoAblumListArr[indexPath.section];

    static NSString *ider = @"headerView";
    UICollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ider forIndexPath:indexPath];
    UILabel *lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, 150, 20)];
    lableTitle.text = photoAblum.title;
    [headView addSubview:lableTitle];
    headView.backgroundColor = [UIColor grayColor];
    
    return headView;
//
//    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
//     
//       CollectionReusableView * headView = [[CollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
//        headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ider forIndexPath:indexPath];
//
//        
//        headView.title.text = @"123";
//        reusableview = headView;
//    }
//    return reusableview;

}
//
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(self.view.bounds.size.width, 50);
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPat{
//    PHAsset *assetModel = _assetArr[indexPat.row];
    
    ZLPhotoAblumList *list = _photoAblumListArr[indexPat.section];
    PHAssetCollection *collert =  list.assetCollection;
    
    //arr  ＝ 获得此相册collert组下的所有照片集
    NSArray *arr =[[ZLPhotoTool sharePhotoTool] getAssetsInAssetCollection:collert ascending:YES];
    //根据indexPath判断现实第几张照片
    PHAsset *assetModel = arr[indexPat.row];
    
    static NSString *ider = @"cell";
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ider forIndexPath:indexPat];
    cell.selectedImg.hidden = YES;
    
    //将PHAsset转换为image形式
    [[ZLPhotoTool sharePhotoTool] requestImageForAsset:assetModel size:CGSizeMake((self.view.bounds.size.width-15)/4, (self.view.bounds.size.width-15)/4) resizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *image, NSDictionary *info) {
        cell.photoImgV.image = image;
    }];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.isSelected.text isEqualToString:@"NO"]) {
        cell.selectedImg.hidden = NO;
        cell.isSelected.text = @"YES";
    }
    
   else if ([cell.isSelected.text isEqualToString:@"YES"]) {
        cell.selectedImg.hidden = YES;
        cell.isSelected.text = @"NO";
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
