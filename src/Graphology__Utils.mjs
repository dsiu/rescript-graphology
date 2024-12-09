// Generated by ReScript, PLEASE EDIT WITH CARE

import * as GraphologyUtils from "graphology-utils";

function MakeUtils(C) {
  return {
    isGraph: prim => GraphologyUtils.isGraph(prim),
    inferMulti: prim => GraphologyUtils.inferMulti(prim),
    inferType: prim => GraphologyUtils.inferType(prim),
    mergeClique: (prim0, prim1) => {
      GraphologyUtils.mergeClique(prim0, prim1);
    },
    mergeCycle: (prim0, prim1) => {
      GraphologyUtils.mergeCycle(prim0, prim1);
    },
    mergePath: (prim0, prim1) => {
      GraphologyUtils.mergePath(prim0, prim1);
    },
    mergeStar: (prim0, prim1) => {
      GraphologyUtils.mergeStar(prim0, prim1);
    },
    renameGraphKeys: (prim0, prim1, prim2) => GraphologyUtils.renameGraphKeys(prim0, prim1, prim2),
    updateGraphKeys: (prim0, prim1, prim2) => GraphologyUtils.updateGraphKeys(prim0, prim1, prim2)
  };
}

export {
  MakeUtils,
}
/* graphology-utils Not a pure module */