import 'package:connect_me/app.dart';
import 'package:flutter/rendering.dart';

class ColorTile extends StatelessWidget {
  final Color color;

  const ColorTile({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 600,
      child: Center(
        child: Text(
          //
          color.toString(),
          style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

List<Color> get allMaterialColors {
  List<Color> allMaterialColorsWithShades = [];

  for (MaterialColor color in Colors.primaries) {
    allMaterialColorsWithShades.add(color.shade100);
    allMaterialColorsWithShades.add(color.shade200);
    allMaterialColorsWithShades.add(color.shade300);
  }
  return allMaterialColorsWithShades;
}

class MoreScreen extends ConsumerStatefulWidget {
  MoreScreen({super.key});

  @override
  ConsumerState<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends ConsumerState<MoreScreen> {
  final materialColorsInGrid = allMaterialColors.take(20).toList();

  final materialColorsInSliverList = allMaterialColors.sublist(20, 25);

  final materialColorsInSpinner = allMaterialColors.sublist(30, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              // MY ACCOUNT
              const Text(TextConstant.yourAccount),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: accountCircleIcon,
                      title: TextConstant.accountInformation,
                      subtitle: TextConstant.nameDisplayPicture,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              accountInformationModal(context, context.textTheme),
                            ];
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              // DottedLineDividerWidget(),
              const Text(TextConstant.otherInformation),

// ADDITIONAL DETAILS
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: additionalDetailsIcon,
                      title: TextConstant.additionalDetails,
                      subtitle: TextConstant.addressCareerEtc,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              additionalInfoModal(context, context.textTheme),
                            ];
                          },
                        );
                      },
                    ),

                    // EDUCATION
                    MoreCustomListTileWidget(
                      icon: educationCapIcon,
                      title: TextConstant.education,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              educationModal(context, context.textTheme),
                            ];
                          },
                        );
                      },
                    ),

                    // WORK EXPERIENCE
                    MoreCustomListTileWidget(
                      icon: workExperienceIcon,
                      title: TextConstant.workExperience,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              workExperienceModal(context, context.textTheme),
                            ];
                          },
                        );
                      },
                    ),

                    MoreCustomListTileWidget(
                      icon: socialMediaIcon,
                      title: TextConstant.socialMediaHandles,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              socialMediaModal(context, context.textTheme),
                            ];
                          },
                        );
                      },
                    ),
                  ],
                ).padOnly(bottom: 7),
              ),
              // DottedLineDividerWidget(),

              // SETTINGS
              const Text('Settings'),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: privacyIcon,
                      title: 'Account Privacy',
                    ),
                    // MoreCustomListTileWidget(
                    //   icon: feedbackSpeakerIcon,
                    //   title: 'Feedbacks',
                    //   iconSize: 26,
                    // ),
                    MoreCustomListTileWidget(
                      icon: helpCenterIcon,
                      title: 'Help Center / Feedbacks',
                      onTap: () {
                        pushAsVoid(context, const HelpCenterScreen());
                      },
                    ),

                    //

                    MoreCustomListTileWidget(
                      icon: supportMoneyIcon,
                      title: TextConstant.support,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              supportModal(context, context.textTheme),
                            ];
                          },
                        );
                      },
                    ),
                    MoreCustomListTileWidget(
                      icon: EvaIcons.link,
                      title: 'Licenses',
                      onTap: () {
                        showLicensePage(
                          context: context,
                          applicationVersion: 'v1.0.0',
                          applicationIcon: Image.asset(
                            ImagesConstant.appLogoBrown,
                            height: 50,
                          ),
                        );
                      },
                    ),
                  ],
                ).padOnly(bottom: 7, top: 4),
              ),
              // DottedLineDividerWidget(),
            ].columnInPadding(10)),
      ),
    );
  }
}

class Shifter extends SingleChildRenderObjectWidget {
  /// Creates an instance of [Shifter].
  const Shifter({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SpinnerRenderSliver();
  }
}

class _SpinnerRenderSliver extends RenderSliver with RenderObjectWithChildMixin<RenderBox> {
  final LayerHandle<TransformLayer> _transformLayer = LayerHandle<TransformLayer>();
  Matrix4? _paintTransform;

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! SliverPhysicalParentData) {
      child.parentData = SliverPhysicalParentData();
    }
  }

  @override
  void performLayout() {
    _paintTransform = null;

    final constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    final double childExtent;
    final childSizeWidth = child!.size.width;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = childSizeWidth;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }

    final paintedChildSize = calculatePaintOffset(
      constraints,
      from: 0.0,
      to: childExtent,
    );
    final cacheExtent = calculateCacheOffset(
      constraints,
      from: 0.0,
      to: childExtent,
    );

    final scrollOffset = constraints.scrollOffset;

    if (scrollOffset > 0 && paintedChildSize > 0) {
      final shift = (1 - paintedChildSize / childExtent) * childSizeWidth;

      _paintTransform = Matrix4.identity()..translate(shift, 0.0);
    }

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow:
          childExtent > constraints.remainingPaintExtent || constraints.scrollOffset > 0.0,
    );

    _setChildParentData(child!, constraints, geometry!);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null && geometry!.visible) {
      _transformLayer.layer = context.pushTransform(
        needsCompositing,
        offset,
        _paintTransform ?? Matrix4.identity(),
        _paintChild,
        oldLayer: _transformLayer.layer,
      );
    } else {
      _transformLayer.layer = null;
    }
  }

  @override
  void applyPaintTransform(covariant RenderObject child, Matrix4 transform) {
    if (_paintTransform != null) {
      transform.multiply(_paintTransform!);
    }
    final childParentData = child.parentData! as SliverPhysicalParentData;

    // for make it more readable
    // ignore: cascade_invocations
    childParentData.applyPaintTransform(transform);
  }

  @override
  void dispose() {
    _transformLayer.layer = null;
    super.dispose();
  }

  void _paintChild(PaintingContext context, Offset offset) {
    final childParentData = child!.parentData! as SliverPhysicalParentData;
    context.paintChild(child!, offset + childParentData.paintOffset);
  }

  void _setChildParentData(
    RenderObject child,
    SliverConstraints constraints,
    SliverGeometry geometry,
  ) {
    final childParentData = child.parentData! as SliverPhysicalParentData;
    var dx = 0.0;
    var dy = 0.0;
    switch (applyGrowthDirectionToAxisDirection(
      constraints.axisDirection,
      constraints.growthDirection,
    )) {
      case AxisDirection.up:
        dy = -(geometry.scrollExtent - (geometry.paintExtent + constraints.scrollOffset));
        break;
      case AxisDirection.right:
        dx = -constraints.scrollOffset;
        break;
      case AxisDirection.down:
        dy = -constraints.scrollOffset;
        break;
      case AxisDirection.left:
        dx = -(geometry.scrollExtent - (geometry.paintExtent + constraints.scrollOffset));
        break;
    }

    childParentData.paintOffset = Offset(dx, dy);
  }
}
