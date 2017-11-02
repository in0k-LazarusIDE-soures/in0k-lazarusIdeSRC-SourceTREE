unit in0k_lazIdeSRC_srcTree_FNK_FILE_FND_abs;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_abs,
  in0k_lazIdeSRC_srcTree_FNK_FILE_FND_rel;

function SrcTree_fndFileABS(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;

implementation

function SrcTree_fndFileABS(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;
var fldr:_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsAbsolute(fileName),'not ASB PATH');{$endIf}
    result:=nil;
    fldr:=SrcTree_fndPathABS(item, srcTree_fsFnk_ExtractFileDir(fileName));
    if Assigned(fldr) then begin
        result:=SrcTree_fndFileREL(fldr, srcTree_fsFnk_CreateRelativePath(fileName,fldr.fsPath));
    end
end;

end.

