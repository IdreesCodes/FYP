import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                    image: DecorationImage(
                      image: AssetImage('assets/images/comtech.png'),
                    )),
              ),
              title: Text(
                'true.idrees',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text('Lahore, Pakistan'),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/comtech.png'),
              )),
            ),
            ListTile(
              leading: Wrap(spacing: 10, children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 27,
                ),
                Icon(
                  Icons.messenger_outline,
                  size: 27,
                ),
                //   Icon(Icons.bookmark_border_outlined,  size: 27,),
              ]),
              trailing: IconButton(
                icon: Icon(
                  Icons.bookmark_border_outlined,
                  size: 27,
                ),
                onPressed: () {},
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '12 likes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
