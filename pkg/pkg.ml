#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let tmpl = [
  "LICENSE.txt";
  "disqus_comments.html";
  "footer.html";
  "google-analytics.html";
  "head.html";
  "header.html";
  "icon-github.html";
  "icon-github.svg";
  "icon-twitter.html";
  "icon-twitter.svg";
] |> List.map (fun x -> Pkg.share ("_includes/"^x))

let () =
  Pkg.describe "minima-theme" @@ fun c ->
  Ok ([ Pkg.mllib "src/minima_theme.mllib";
       Pkg.test "test/test"; ] @ tmpl)
