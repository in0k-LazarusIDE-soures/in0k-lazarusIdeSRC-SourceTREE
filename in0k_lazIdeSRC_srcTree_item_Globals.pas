unit in0k_lazIdeSRC_srcTree_item_Globals;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem;

type

  tSrcTree_ROOT=class(tSrcTree_item);
  tSrcTree_BASE=class(_tSrcTree_item_fsBaseDIR_);
  tSrcTree_MAIN=class(_tSrcTree_item_fsNodeFILE_);

  tSrcTree_Root4Package=class(tSrcTree_ROOT);
  tSrcTree_Main4Package=class(tSrcTree_MAIN);

  tSrcTree_Root4Project=class(tSrcTree_ROOT);
  tSrcTree_Main4Project=class(tSrcTree_MAIN);

implementation

end.

