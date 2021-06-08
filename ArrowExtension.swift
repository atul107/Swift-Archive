#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (ArrowExtension)

/**
 Function to add an arrow from the currentPoint.

 @param point         The point of the arrow
 @param controlPoint  The point from which the arrow is aligned. Typically, this will be the
                      control point for the previous quad/cubic bezier, or if dealing with a
                      line, the starting point.
 @param width         The width of the arrow (distance from the line).
 @param height        The height of the arrow (distance from the start point).
 @param isOpen        Whether the arrowhead is open or closed.
 */

- (void)addArrowFrom:(CGPoint)point
        controlPoint:(CGPoint)controlPoint
               width:(CGFloat)width
              height:(CGFloat)height
              isOpen:(BOOL)isOpen
              isInverse:(BOOL)isInverse;


@end

NS_ASSUME_NONNULL_END
