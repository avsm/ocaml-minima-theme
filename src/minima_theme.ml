(*---------------------------------------------------------------------------
   Copyright (c) 2016 Anil Madhavapeddy. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

open Soup

let u = Uri.of_string

let replace_child ~child soup =
  clear soup;
  append_child soup child

let replace_text ~text soup =
  clear soup;
  append_child soup (create_text text)

type t = {
  tmpl: string -> soup node;
}

let default_theme_dir =
  let open Bos in
  let open Rresult in
  let opam_cmd = Cmd.(v "opam"%"config"%"var"%"share") in
  OS.Cmd.(run_out opam_cmd |> to_string ~trim:true) |> function
  | Error (`Msg m) -> Fmt.epr "Could not find opam install for minima-theme\n%s\n%!" m; None
  | Ok path -> Some (Fpath.(v path / "minima-theme" |> to_string))

let v ?base_dir () =
  let base_dir =
    match base_dir, default_theme_dir with
    | Some d, _ -> d
    | None, Some d -> d
    | None, None -> Fmt.epr "Need to specify a theme dir or `opam install minima-theme`\n%!"; exit 1
  in
  let tmpl f = read_file (base_dir^"/"^f) |> parse in
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
