#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "minima-theme" @@ fun c ->
  Ok [ Pkg.mllib "src/minima_theme.mllib";
       Pkg.test "test/test"; ]
