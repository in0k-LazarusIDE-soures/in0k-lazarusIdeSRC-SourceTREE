unit in0k_lazIdeSRC_srcTree_item_Globals;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_coreFileSystem;

type

  tSrcTree_ROOT= tSrcTree_item;
  tSrcTree_BASE=_tSrcTree_item_fsBaseDIR_;
  tSrcTree_MAIN=_tSrcTree_item_fsNodeFILE_;

  tSrcTree_Root4Package=tSrcTree_ROOT;
  tSrcTree_Main4Package=tSrcTree_MAIN;

  tSrcTree_Root4Project=tSrcTree_ROOT;
  tSrcTree_Main4Project=tSrcTree_MAIN;

implementation

end.

