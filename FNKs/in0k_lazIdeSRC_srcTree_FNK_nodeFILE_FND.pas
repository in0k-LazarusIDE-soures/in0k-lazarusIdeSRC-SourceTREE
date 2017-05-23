unit in0k_lazIdeSRC_srcTree_FNK_nodeFILE_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  in0k_lazIdeSRC_srcTree_coreFileSystemFNK,
  in0k_lazIdeSRC_srcTree_FNK_relPATH_FND;


function SrcTree_fndNodeFILE(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;

implementation

function SrcTree_fndNodeFILE(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;
begin
    // ищем папку
    result:=tSrcTree_fsFILE(tSrcTree_item(SrcTree_fndRelPATH(item,srcTree_fsFnk_ExtractFileDir(fileName))));
    // ищем сам файл внутри него
    if Assigned(result) then begin
        result:=tSrcTree_fsFILE(tSrcTree_item(result).ItemCHLD);
        while Assigned(result) do begin
            if tSrcTree_item(result) is tSrcTree_fsFILE then begin //< мы же тока файлы исчем
                if 0=srcTree_fsFnk_CompareFilenames(result.src_Name, srcTree_fsFnk_ExtractFileName(fileName)) then begin
                    BREAK;
                end;
            end;
            //-->
            result:=tSrcTree_fsFILE(tSrcTree_item(result).ItemCHLD);
        end;
    end;
end;

end.

