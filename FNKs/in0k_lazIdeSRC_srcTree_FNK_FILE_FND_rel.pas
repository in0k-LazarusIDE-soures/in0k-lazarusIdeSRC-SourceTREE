unit in0k_lazIdeSRC_srcTree_FNK_FILE_FND_rel;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel;


function SrcTree_fndFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const fileName:string):tSrcTree_fsFILE;
//
function SrcTree_fndFileREL(const item: tSrcTree_fsFLDR;           const fileName:string):tSrcTree_fsFILE;
function SrcTree_fndFileREL(const item: tSrcTree_BASE;             const fileName:string):tSrcTree_fsFILE;
function SrcTree_fndFileREL(const item: tSrcTree_ROOT;             const fileName:string):tSrcTree_fsFILE;

implementation

function _fndNodeFILE_(const item:_tSrcTree_item_fsNodeFLDR_; const OnlyFileName:string):tSrcTree_fsFILE; {$ifOpt D-}inline;{$endIf}
begin
    result:=tSrcTree_fsFILE(tSrcTree_item(item).ItemCHLD);
    while Assigned(result) do begin
        if tSrcTree_item(result) is _tSrcTree_item_fsNodeFILE_ then begin //< мы же тока файлы исчем
            if 0=srcTree_fsFnk_CompareFilenames(result.fsName, OnlyFileName) then begin
                BREAK;
            end;
        end;
        //-->
        result:=tSrcTree_fsFILE(tSrcTree_item(result).ItemNEXT);
    end;
end;

//------------------------------------------------------------------------------

// Поиск файла ОТНОСИТЕЛЬНО директории
function SrcTree_fndFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const fileName:string):tSrcTree_fsFILE;
begin
    {$ifOpt D+}Assert(Assigned(item),'item is NULL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsRelative(fileName),'not REL PATH');{$endIf}
    // ищем папку
    result:=tSrcTree_fsFILE(tSrcTree_item(SrcTree_fndPathREL(item,srcTree_fsFnk_ExtractFileDir(fileName))));
    // ищем сам файл внутри него
    if Assigned(result) then begin
        result:=_fndNodeFILE_(_tSrcTree_item_fsNodeFLDR_(tSrcTree_item(result)), srcTree_fsFnk_ExtractFileName(fileName));
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Поиск файла ОТНОСИТЕЛЬНО директории
function SrcTree_fndFileREL(const item:tSrcTree_fsFLDR; const fileName:string):tSrcTree_fsFILE;
begin
    {$ifOpt D+}Assert(Assigned(item),'item is NULL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsRelative(fileName),'not REL PATH');{$endIf}
    result:=SrcTree_fndFileREL(_tSrcTree_item_fsNodeFLDR_(item), fileName);
end;

// Поиск файла ОТНОСИТЕЛЬНО директории проэкта
function SrcTree_fndFileREL(const item:tSrcTree_BASE; const fileName:string):tSrcTree_fsFILE;
begin
    {$ifOpt D+}Assert(Assigned(item),'item is NULL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsRelative(fileName),'not REL PATH');{$endIf}
    result:=SrcTree_fndFileREL(_tSrcTree_item_fsNodeFLDR_(item), fileName);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Поиск файла ОТНОСИТЕЛЬНО "БАЗОВОЙ" директории проэкта
function SrcTree_fndFileREL(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;
begin
    {$ifOpt D+}Assert(Assigned(item),'item is NULL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsRelative(fileName),'not REL PATH');{$endIf}
    // ищем целевую директорию, ОТНОСИТЕЛЬНО базового пути,
    // поиск проводим ОТНОСИТЕЛЬНО её
    result:=tSrcTree_fsFILE(tSrcTree_item(SrcTree_fndPathREL(item,srcTree_fsFnk_ExtractFileDir(fileName))));
    // ищем сам файл внутри него
    if Assigned(result) then begin
        result:=_fndNodeFILE_(_tSrcTree_item_fsNodeFLDR_(tSrcTree_item(result)), srcTree_fsFnk_ExtractFileName(fileName));
    end;
end;

end.
