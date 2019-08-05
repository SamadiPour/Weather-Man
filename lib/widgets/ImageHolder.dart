import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class ImageHolder extends StatelessWidget {
    final String path;
    final String onErrorPath;
    final double aspectRatio;
    final double width;

    ImageHolder(this.path, {this.onErrorPath, this.aspectRatio, this.width});

    bool found;

    @override
    Widget build(BuildContext context) {
        return FutureBuilder<bool>(
            future: _findAsset(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                        return Shimmer.fromColors(
                            highlightColor: Colors.white,
                            baseColor: Colors.grey[300],
                            child: AspectRatio(
                                aspectRatio: aspectRatio,
                                child: Container(
                                    width: width,
                                    color: Colors.grey,
                                ),
                            ),
                        );
                        break;
                    case ConnectionState.done:
                        return Image.asset(found ? path : onErrorPath,
                            width: width,
                        );
                    default:
                        return null;
                }
            },
        );
    }

    Future<bool> _findAsset() async {
        try {
            await rootBundle.load(path);
            found = true;
        } catch (_) {
            if (onErrorPath != null) {
                try {
                    await rootBundle.load(onErrorPath);
                    found = false;
                } catch (_) {
                    return null;
                }
            }
        }
        return null;
    }
}