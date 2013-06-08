//
//  LGMapViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LGMapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
	IBOutlet	MKMapView   *_mapView;
    IBOutlet    UIView      *_searchView;
	IBOutlet    UITextField *_searchTextField;
	MKUserLocation          *_currentlocation;
	MKPointAnnotation       *_currentAnnotation;
	MKPointAnnotation       *_lastPoint;
	//MKReverseGeocoder       *_reverseGeocoder;
	NSString                *_latStr;
	NSString                *_lngStr;
	NSString                *_address;
}

@property (nonatomic,retain) MKMapView		   *mapView;
@property (nonatomic,retain) UIView			   *searchView;
@property (nonatomic,retain) UITextField       *searchTextField;
@property (nonatomic,retain) MKUserLocation    *currentlocation;
//@property (nonatomic,retain) MKReverseGeocoder *reverseGeocoder;
@property (nonatomic,retain) NSString          *address;
@property (nonatomic,retain) NSString          *latStr;
@property (nonatomic,retain) NSString          *lngStr;
@property (nonatomic,retain) CLGeocoder        *myGeocoder;

- (IBAction) dingwei;
- (IBAction) startSearch;
- (IBAction) Search;
- (IBAction) back;
- (IBAction) keyboard;
- (IBAction) setting;

- (void) showAddressMessage;

@end
