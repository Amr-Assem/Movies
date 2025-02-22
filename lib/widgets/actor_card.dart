import 'package:flutter/material.dart';
import 'package:movies_app/core/app_assets.dart';

class ActorCard extends StatelessWidget {
  final actor;

  const ActorCard({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppAssets.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              actor.urlSmallImage,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  'Name: ${actor.name}',
                  style: TextStyle(
                    color: AppAssets.white,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Character: ${actor.characterName ?? ''}',
                  style: TextStyle(
                    color: AppAssets.white,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
