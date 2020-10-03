import 'dart:io';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

class UserPhotoUpload extends StatefulWidget {
  final Function(File) onImageSubmit;
  final String imageUrl;
  const UserPhotoUpload({
    Key key,
    @required this.onImageSubmit,
    this.imageUrl,
  })  : assert(onImageSubmit != null),
        super(key: key);

  @override
  _UserPhotoUploadState createState() => _UserPhotoUploadState();
}

class _UserPhotoUploadState extends State<UserPhotoUpload> {
  final picker = ImagePicker();
  File _image;
  ImageSource _imageSource;
  @override
  Widget build(BuildContext context) {
    if (_image == null && widget.imageUrl == null) {
      return Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              _buildPanelSwitch(context, () async {
                await getImage();
              });
            },
            child: userPhoto(),
          ),
        ),
      );
    } else if (_image == null && widget.imageUrl != null) {
      return Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              _buildPanelSwitch(context, () async {
                await getImage();
              });
            },
            child: userPhoto(photoUrl: widget.imageUrl),
          ),
        ),
      );
    } else {
      return Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              _buildPanelSwitch(context, () async {
                await getImage();
              });
            },
            child: userPhoto(imageFile: _image),
          ),
        ),
      );
    }
  }

  void _setState(VoidCallback lSetState) {
    if (mounted) {
      setState(lSetState);
    }
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: _imageSource);
      _setState(() => _image = File(pickedFile.path));
      if (widget.onImageSubmit != null) widget.onImageSubmit(_image);
    } catch (e) {
      print("CANCELLED, Error: $e");
      return;
    }
  }

  Widget userPhoto({String photoUrl, File imageFile}) {
    if (photoUrl != null) {
      return Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: CColors.inActiveButtonColor,
            backgroundImage: NetworkImage(photoUrl),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: CColors.activeCatColor,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.cog,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (imageFile != null) {
      return Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: CColors.inActiveButtonColor,
            backgroundImage: FileImage(imageFile),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: CColors.activeCatColor,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.cog,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 30,
          backgroundColor: CColors.inActiveButtonColor,
          child: FaIcon(
            FontAwesomeIcons.userAlt,
            size: 30,
            color: CColors.activeCatColor,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: CColors.activeCatColor,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.cog,
                color: Colors.white,
                size: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildPanelSwitch(BuildContext context, VoidCallback callback) {
    if (isMaterial(context)) {
      _androidPopupContent(context, callback);
      return;
    }

    showPlatformModalSheet(
      context: context,
      builder: (_) {
        return PlatformWidget(
          cupertino: (_, __) => _cupertinoSheetContent(context, callback),
        );
      },
    );
  }

  void _androidPopupContent(BuildContext context, VoidCallback callback) {
    final trs = AppTranslations.of(context);
    return PlatformActionSheet().displaySheet(
      context: context,
      title: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            trs.translate("image_source"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      message: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            trs.translate("image_source_des"),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: [
        ActionSheetAction(
          text: trs.translate("from_gallery"),
          onPressed: () {
            Navigator.pop(context);
            _setState(() => _imageSource = ImageSource.gallery);
            Future.delayed(Duration(milliseconds: 200), () {
              callback();
            });
          },
        ),
        ActionSheetAction(
          text: trs.translate("from_camera"),
          onPressed: () {
            Navigator.pop(context);
            _setState(() => _imageSource = ImageSource.camera);
            Future.delayed(Duration(milliseconds: 200), () {
              callback();
            });
          },
        ),
        ActionSheetAction(
          text: "Cancel",
          onPressed: () => Navigator.pop(context),
          isCancel: true,
          defaultAction: true,
        )
      ],
    );
  }

  Widget _cupertinoSheetContent(BuildContext context, VoidCallback callback) {
    final trs = AppTranslations.of(context);
    return CupertinoActionSheet(
      title: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            trs.translate("image_source"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      message: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            trs.translate("image_source_des"),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            trs.translate("from_gallery"),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            _setState(() => _imageSource = ImageSource.gallery);
            Future.delayed(Duration(milliseconds: 200), () {
              callback();
            });
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            trs.translate("from_camera"),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            _setState(() => _imageSource = ImageSource.camera);
            Future.delayed(Duration(milliseconds: 200), () {
              callback();
            });
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    );
  }
}
