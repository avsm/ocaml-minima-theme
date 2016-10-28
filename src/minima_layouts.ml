(*---------------------------------------------------------------------------
   Copyright (c) 2016 Anil Madhavapeddy. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

open Soup
open Minima_theme

type html = Soup.soup Soup.node

let default ?(lang="en") ~head ~header ~content ~footer () =
  create_element ~attributes:["lang",lang] "html" |> fun html ->
  append_child html head;
  create_element "body" |> fun body ->
  append_child html body;
  append_child body header;
  create_element ~class_:"page-content" ~attributes:["aria-label","Content"] "main" |> fun main ->
  append_child body main;
  create_element ~class_:"wrapper" "div" |> fun wrapper ->
  append_child main wrapper;
  append_child wrapper content;
  append_child body footer;
  html

let article ~title ~date ~content =
  let rfc_date = Fmt.strf "%a" (Ptime.pp_rfc3339 ()) date in
  let text_date = Fmt.strf "%a" (Ptime.pp_rfc3339 ~space:true ()) date in
  create_element ~attributes:["itemscope",""; "itemtype","http://schema.org/BlogPosting"]
    ~class_:"post" "article" |> fun article ->
  create_element ~class_:"post-header" "header" |> fun header ->
  append_child article header;
  create_element ~class_:"post-title" ~attributes:["itemprop","name headline"]
    ~inner_text:title "h1" |> fun h1 ->
  append_child header h1;
  create_element ~class_:"post-meta" "p" |> fun p ->
  append_child h1 p;
  create_element ~inner_text:text_date
    ~attributes:["datetime",rfc_date; "itemprop","datePublished"] "time" |> fun time_tag ->
  append_child p time_tag;
  append_child p (create_text " • ");
  create_element ~class_:"post-content" ~attributes:["itemprop","articleBody"] "div" |> fun post_div ->
  append_child article post_div;
  append_child post_div content;
  article
  
let home ~content ~rss_feed_uri ~posts =
  create_element ~class_:"home" "div" |> fun home_div ->
  create_element ~class_:"page-heading" ~inner_text:"Posts" "h1" |> fun h1 ->
  append_child home_div h1;
  append_child home_div content;
  create_element ~class_:"post-list" "ul" |> fun ul ->
  append_child home_div ul;
  List.iter (fun (date, href, title) ->
    let post_date = Fmt.strf "%a" (Ptime.pp_rfc3339 ()) date in
    create_element "li" |> fun li ->
    append_child ul li;
    create_element ~class_:"post-meta" ~inner_text:post_date "span" |> append_child li;
    append_child li (create_text " ");
    create_element "h2" |> fun h2 ->
    append_child li h2;
    create_element ~class_:"post-link" ~attributes:["href",Uri.to_string href] ~inner_text:title "a" |> append_child li
  ) posts;
  create_element ~class_:"rss-subscribe" ~inner_text:"subscribe " "p" |> fun p_rss ->
  append_child p_rss (create_element ~attributes:["href", Uri.to_string rss_feed_uri] "a");
  append_child home_div p_rss;
  home_div

let to_string s =
  "<!DOCTYPE html>\n" ^ (Soup.to_string s)

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
