unit in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  //
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_fsFile;

type // создание ЭКЗеМпЛЯРа "ФАЙЛ"
  {todo: добавить методы для nested}
  fSrcTree_crt_FsFILE_callBACK=function(const FilePath:string{; const FileKind:TPkgFileType}):tSrcTree_fsFILE;
  mSrcTree_crt_FsFILE_callBACK=function(const FilePath:string{; const FileKind:TPkgFileType}):tSrcTree_fsFILE of object;

//---

function SrcTree_addFsFILE(const item:tSrcTree_item; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_addFsFILE(const item:tSrcTree_item; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}

implementation

function SrcTree_addFsFILE(const item:tSrcTree_item; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD.inc}

function SrcTree_addFsFILE(const item:tSrcTree_item; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD.inc}

end.

