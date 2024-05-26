import "package:customer/models/list_model.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class ListCardView extends StatelessWidget {
  const ListCardView({
    required this.pagingController,
    required this.onTap,
    super.key,
  });

  final PagingController<int, Lists> pagingController;
  final Function(Lists item) onTap;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Lists>(
      pagingController: pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<Lists>(
        itemBuilder: (BuildContext context, Lists item, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4,
            child: InkWell(
              onTap: () => onTap(item),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8.0),
                        ),
                        image: DecorationImage(
                          image: AssetImage(AppAssetsImages().product),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.name ?? "Unknown",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.description ?? "No description available.",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "\$${item.price}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (item.originalPrice != null)
                              Text(
                                "\$${item.originalPrice}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                        if (item.discount != null)
                          Text(
                            "${item.discount}%",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
