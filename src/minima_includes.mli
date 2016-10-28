(*---------------------------------------------------------------------------
   Copyright (c) 2016 Anil Madhavapeddy. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

(** HTML fragments for use in higher-level layouts.

    Functions from this module generate HTML fragments that are then
    used in complete HTML generation functions in {!Minima_layouts}. *)

type html = Soup.soup Soup.node

val header :
  title:string ->
  title_uri:Uri.t ->
  page_links: (string * Uri.t) list ->
  Minima_theme.t -> html

val head :
  title:string ->
  description:string ->
  stylesheet_uri:Uri.t ->
  canonical_uri:Uri.t ->
  rss_feed_uri:Uri.t ->
  Minima_theme.t -> html

val footer :
  title:string ->
  description:string ->
  contacts:(string * Uri.t option) list ->
  icons:html list ->
  Minima_theme.t -> html

val icon :
  service:string ->
  base_uri:Uri.t ->
  username:string ->
  Minima_theme.t -> html

val icon_twitter :
  username:string ->
  Minima_theme.t -> html

val icon_github :
  username:string ->
  Minima_theme.t -> html

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
