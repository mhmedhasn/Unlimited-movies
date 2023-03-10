import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/TopReated.dart';
import 'package:provider/provider.dart';

import '../../../provider/myProvider.dart';
import '../movie_detiels_screen/movie_detiels.dart';

class SearchItems extends StatelessWidget {
  Results results;

  SearchItems(this.results);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var provider = Provider.of<Myprovider>(context);

    return Container(
      width: double.infinity,
      height: h*0.21,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            Row(
              children: [
                InkWell(
                  onTap: () {
                    provider.result_ID = results.id!;
                    print(provider.result_ID);
                    Navigator.pushNamed(context, MovieDetiels.routeName,
                        arguments: results);
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child:
                                CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original${results.backdropPath ?? ''}',
                                width: w * .40,
                                height: h * 0.15,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: w*0.40,
                                    child: Text(
                                      results.title.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    results.releaseDate!,
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white70),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 18,
                                      ),
                                      Text(
                                        results.voteAverage.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),

              ],
            ),
            SizedBox(height: 3,),
            Divider(
              height: 2,
              color: Colors.white70,
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
