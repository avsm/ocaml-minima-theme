(*---------------------------------------------------------------------------
   Copyright (c) 2016 Anil Madhavapeddy. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

(** HTML layouts for different sorts of Minima pages. *)

(** {1 Top-level HTML generation} *)

val default :
  ?lang:string ->
  title:string ->
  title_uri:Uri.t ->
  description:string ->
  stylesheet_uri:Uri.t ->
  canonical_uri:Uri.t ->
  rss_feed_uri:Uri.t ->
  contacts:(string * Uri.t option) list ->
  page_links:(string * Uri.t) list ->
  icons:Minima_includes.html list ->
  content:'a Soup.node -> Minima_theme.t -> Soup.element Soup.node

val to_string : 'a Soup.node -> string
(** [to_string s] will convert the HTML nodes to an HTML string
    and also prepend a [DOCTYPE] tag so that browsers interpret
    it properly. *)


val article :
  title:string ->
  date:Ptime.t ->
  content:'a Soup.node ->
  Soup.element Soup.node

val home :
  content:'a Soup.node ->
  rss_feed_uri:Uri.t ->
  posts:(Ptime.t * Uri.t * string) list ->
  Soup.element Soup.node

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
