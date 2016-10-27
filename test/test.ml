(*---------------------------------------------------------------------------
   Copyright (c) 2016 Anil Madhavapeddy. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

let () =
  let open Minima_includes in
  let u = Uri.of_string in
  let title = "Test" in
  let description = "A description" in
  let stylesheet_uri = u "/css/main.css" in
  let canonical_uri = u "http://anil.recoil.org" in
  let rss_feed_uri = u "/feed.xml" in
  let username = "avsm" in
  let page_links = ["About", u"/about"] in
  let contact_email = "anil@recoil.org", (Some (u "mailto:anil@recoil.org")) in
  let contact_name = "Anil Madhavapeddy", None in
  let contacts = [contact_name; contact_email] in
  let t = Minima_theme.v () in
  let icons = [icon_twitter ~username t; icon_github ~username t] in
  header ~title ~title_uri:canonical_uri ~page_links t |> fun header ->
  head ~title ~description ~stylesheet_uri ~canonical_uri ~rss_feed_uri t |> fun head ->
  footer ~title ~contacts ~icons ~description t |> fun footer ->
  let open Soup in
  to_string header |> print_endline;
  to_string head |> print_endline;
  to_string footer |> print_endline

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
