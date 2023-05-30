import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_app_flutter/ui/widgets/rounded_icon_button.dart';
import 'package:tinder_app_flutter/ui/widgets/image_portrait.dart';
import 'package:tinder_app_flutter/util/constants.dart';

class AddPhotoScreen extends StatefulWidget {
  final Function(List<String>) onPhotosChanged;

  AddPhotoScreen({@required this.onPhotosChanged});

  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final picker = ImagePicker();
  List<String> _imagePaths = [];

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null && _imagePaths.length < 9) {
      _imagePaths.add(pickedFile.path);
      widget.onPhotosChanged(_imagePaths);
    }
  }

  void clearImage(int index) {
    _imagePaths.removeAt(index);
    widget.onPhotosChanged(_imagePaths);
  }

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = 3 / 4;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Adicionar fotos',
            style: Theme.of(context).textTheme.headline3,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: _imagePaths.length < 9 ? _imagePaths.length + 1 : 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                if (index == _imagePaths.length) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          border: Border.all(
                            width: 2,
                            color: kAccentColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RoundedIconButton(
                          onPressed: pickImageFromGallery,
                          iconData: Icons.add,
                          iconSize: 20,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: aspectRatio,
                        child: ImagePortrait(
                          imagePath: _imagePaths[index],
                          imageType: ImageType.FILE_IMAGE,
                        ),
                      ),
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
                            onPressed: () => clearImage(index),
                            icon: Icon(Icons.clear),
                            color: Colors.black,
                            iconSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
