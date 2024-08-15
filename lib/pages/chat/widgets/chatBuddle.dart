import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello/config/images.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isComing;
  final String time;
  final String status;
  final String imageUrl;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isComing,
    required this.time,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: isComing ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: MediaQuery.sizeOf(context).width / 1.3,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: isComing
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(15),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(0),
                        )),
              child: imageUrl == ""
                  ? Text(message)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        message == "" ? Container() : const SizedBox(height: 10),
                        message == "" ? Container() : Text(message),
                      ],
                    )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: isComing ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              isComing
                  ? Text(
                      time,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  : Row(
                      children: [
                        Text(
                          time,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          AssetsImage.chatStatusSVG,
                          width: 20,
                        ),
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }
}
