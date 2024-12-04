// Generated by ReScript, PLEASE EDIT WITH CARE

import * as GraphologyUtils from "graphology-utils";

function MakeUtils(C) {
  return {
          isGraph: (function (prim) {
              return GraphologyUtils.isGraph(prim);
            }),
          inferMulti: (function (prim) {
              return GraphologyUtils.inferMulti(prim);
            }),
          inferType: (function (prim) {
              return GraphologyUtils.inferType(prim);
            }),
          mergeClique: (function (prim0, prim1) {
              GraphologyUtils.mergeClique(prim0, prim1);
            }),
          mergeCycle: (function (prim0, prim1) {
              GraphologyUtils.mergeCycle(prim0, prim1);
            }),
          mergePath: (function (prim0, prim1) {
              GraphologyUtils.mergePath(prim0, prim1);
            }),
          mergeStar: (function (prim0, prim1) {
              GraphologyUtils.mergeStar(prim0, prim1);
            }),
          renameGraphKeys: (function (prim0, prim1, prim2) {
              return GraphologyUtils.renameGraphKeys(prim0, prim1, prim2);
            }),
          updateGraphKeys: (function (prim0, prim1, prim2) {
              return GraphologyUtils.updateGraphKeys(prim0, prim1, prim2);
            })
        };
}

export {
  MakeUtils ,
}
/* graphology-utils Not a pure module */