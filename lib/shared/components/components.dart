import 'package:flutter/material.dart';
import 'package:news/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(Map map, context) => InkWell(
  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(map['url'])));},
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: 120,
          height: 120,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: map['urlToImage'] != null ? Image.network(map['urlToImage'], fit: BoxFit.cover) : Container(),
        ),
        Expanded(
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                      map['title'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                      // style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                    )
                ),
                Text(map['publishedAt'], style: const TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
          ),
        )
      ],
    ),
  )
);

Widget buildTextFormField({
  @required TextEditingController textEditingController,
  @required TextInputType textInputType,
  bool obscureText = false,
  Function onFieldSubmitted,
  Function onChanged,
  Function onTap,
  Function validator,
  String labelText,
  IconData prefixIcon,
  IconData suffixIcon,
  Function suffixIconPressed,
}) => TextFormField(
  controller: textEditingController,
  keyboardType: textInputType,
  obscureText: obscureText,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  onTap: onTap,
  validator: validator,
  decoration: InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(prefixIcon),
    suffixIcon: suffixIcon != null ? IconButton(
      icon: Icon(suffixIcon),
      onPressed: suffixIconPressed,
    ) : null,
    border: const OutlineInputBorder(),
  ),
);