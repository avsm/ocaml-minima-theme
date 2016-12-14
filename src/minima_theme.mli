(*---------------------------------------------------------------------------
   Copyright (c) 2016 Anil Madhavapeddy. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

(** Port of Jekyll Minima theme as an OCaml library

    {e %%VERSION%% — {{:%%PKG_HOMEPAGE%% }homepage}} *)

(** {1 Template handling} *)
type t = {
  tmpl: string -> Soup.soup Soup.node;
}

val v : ?base_dir:string -> unit -> t
(** [v ?base_dir] constructs a Minima_theme handler that uses templates
  from [base_dir].  If [base_dir] is not specified, it defaults to the
  value of [opam config var minima-theme:share].  This requires an active
  OPAM installation at the runtime of the library (this limitation will
  be lifted in a future release). *)

(** {1 Convenience functions} *)

val u : string -> Uri.t
(** [u] is a convenience alias for {!Uri.of_string} *)

val replace_child: child:('a Soup.node) -> Soup.element Soup.node -> unit

val replace_text: text:string -> Soup.element Soup.node -> unit

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
