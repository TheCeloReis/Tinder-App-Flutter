import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_app_flutter/ui/widgets/rounded_icon_button.dart';
import 'package:tinder_app_flutter/ui/widgets/image_portrait.dart';

class AddPhotoScreen extends StatefulWidget {
  final Function(String) onPhotoChanged;

  AddPhotoScreen({@required this.onPhotoChanged});

  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final picker = ImagePicker();
  String _imagePath;

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onPhotoChanged(pickedFile.path);

      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void clearImage() {
    setState(() {
      _imagePath = null;
      widget.onPhotoChanged(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Adicionar foto',
            style: Theme.of(context).textTheme.headline3,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        child: _imagePath == null
                            ? ImagePortrait(imageType: ImageType.NONE)
                            : ImagePortrait(
                                imagePath: _imagePath,
                                imageType: ImageType.FILE_IMAGE,
                              ),
                      ),
                      if (_imagePath != null)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: clearImage,
                              icon: Icon(Icons.clear),
                              color: Colors.black,
                              iconSize: 16,
                            ),
                          ),
                        ),
                      if (_imagePath == null)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: RoundedIconButton(
                              onPressed: pickImageFromGallery,
                              iconData: Icons.add,
                              iconSize: 24,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
