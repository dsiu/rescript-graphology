// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Caml_option from "rescript/lib/es6/caml_option.js";
import GraphologySvg from "graphology-svg";

function MakeSVG(C) {
  return {
          render: (function (prim0, prim1, prim2, prim3) {
              GraphologySvg(prim0, prim1, prim2 !== undefined ? Caml_option.valFromOption(prim2) : undefined, prim3);
            })
        };
}

export {
  MakeSVG ,
}
/* graphology-svg Not a pure module */
