(*---------------------------------------------------------------------------
   Copyright (c) 2016 Anil Madhavapeddy. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

open Soup
open Minima_theme

type html = Soup.soup Soup.node

let header ~title ~title_uri ~page_links {tmpl} =
  tmpl "header.html" |> fun soup ->
  soup $ "a[class=site-title]" |> fun title_soup ->
  set_attribute "href" (Uri.to_string title_uri) title_soup;
  replace_text ~text:title title_soup;
  soup $ "div[class=trigger]" |> fun trigger_soup ->
  clear trigger_soup;
  List.iter (fun (page_text, page_uri) ->
    let class_ = "page-link" in
    let attributes = ["href", Uri.to_string page_uri] in
    create_element ~class_ ~attributes ~inner_text:page_text "a" |>
    append_child trigger_soup
  ) page_links;
  soup

let head ~title ~description ~stylesheet_uri ~canonical_uri ~rss_feed_uri {tmpl} =
  tmpl "head.html" |> fun soup ->
  soup $ "title" |> replace_text ~text:title;
  soup $ "meta[name=description]" |> set_attribute "content" description;
  soup $ "link[rel=stylesheet]" |> set_attribute "href" (Uri.to_string stylesheet_uri);
  soup $ "link[rel=canonical]" |> set_attribute "href" (Uri.to_string canonical_uri);
  soup $ "link[rel=alternate]" |> set_attribute "title" title;
  soup $ "link[rel=alternate]" |> set_attribute "href" (Uri.to_string rss_feed_uri);
  soup

let footer ~title ~description ~contacts ~icons {tmpl} =
  tmpl "footer.html" |> fun soup ->
  soup $ "h2[class=footer-heading]" |> replace_text ~text:title;
  soup $ "ul[class=contact-list]" |> fun contact_soup ->
  clear contact_soup;
  List.iter (fun (text, uri) ->
    create_element "li" |> fun li ->
    (match uri with
    | None ->
       create_text text |> append_child li
    | Some uri ->
       create_element ~attributes:["href",Uri.to_string uri] ~inner_text:text "a" |>
       append_child li);
    append_child contact_soup li
  ) contacts;
  soup $ "ul[class=social-media-list]" |> fun social_soup ->
  clear social_soup;
  List.iter (fun icon ->
    create_element "li" |> fun li ->
    append_child li icon;
    append_child social_soup li
  ) icons;
  soup $ "div[class*=footer-col-3]" |> replace_child ~child:(create_element ~inner_text:description "p");
  soup

let icon ~service ~base_uri ~username {tmpl} =
  tmpl (Fmt.strf "icon-%s.svg" service) |> fun icon_svg ->
  tmpl (Fmt.strf "icon-%s.html" service) |> fun soup ->
  soup $ "a" |> set_attribute "href" (Fmt.strf "%s/%s" (Uri.to_string base_uri) username);
  soup $ (Fmt.strf "span[class=icon icon--%s]" service) |> replace_child ~child:icon_svg;
  soup $ "span[class=username]" |> replace_text ~text:username;
  soup

let icon_twitter = icon ~service:"twitter" ~base_uri:(u "https://twitter.com")
let icon_github = icon ~service:"github" ~base_uri:(u "https://github.com")

let v ?(base_dir="_includes/") () = 
  let tmpl f = read_file (base_dir^f) |> parse in
  {tmpl}
  
(*---------------------------------------------------------------------------
   Copyright (c) 2016 Anil Madhavapeddy

   Permission to use, copy, modify, and/or distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
   ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  ---------------------------------------------------------------------------*)
