unit in0k_lazIdeSRC_srcTree_FNK_FILE_FND_rel;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel;


function SrcTree_fndFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const filePath:string):_tSrcTree_item_fsNodeFILE_;
//
function SrcTree_fndFileREL(const item: tSrcTree_fsFLDR;           const filePath:string):_tSrcTree_item_fsNodeFILE_;
function SrcTree_fndFileREL(const item: tSrcTree_BASE;             const filePath:string):_tSrcTree_item_fsNodeFILE_;
function SrcTree_fndFileREL(const item: tSrcTree_ROOT;             const filePath:string):_tSrcTree_item_fsNodeFILE_;

implementation

// поиск файла как СЫНА в указанной item
function _fndNodeFILE_(const item:_tSrcTree_item_fsNodeFLDR_; const OnlyFileName:string):_tSrcTree_item_fsNodeFILE_; {$ifOpt D-}inline;{$endIf}
begin
    result:=_tSrcTree_item_fsNodeFILE_(item.ItemCHLD);
    while Assigned(result) do begin
        if tSrcTree_item(result) is _tSrcTree_item_fsNodeFILE_ then begin //< мы же тока файлы исчем
            if srcTree_fsFnk_namesIdentical( _tSrcTree_item_fsNodeFILE_(result).fsName, OnlyFileName)
            then BREAK; //< НАШЛИ
        end;
        //-->
        result:=_tSrcTree_item_fsNodeFILE_(result.ItemNEXT);
    end;
end;

//------------------------------------------------------------------------------

// Поиск файла ОТНОСИТЕЛЬНО директории
function SrcTree_fndFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const filePath:string):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}Assert(Assigned(item),'item is NULL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_pathIsRelative(filePath),'not REL PATH');{$endIf}
    // ищем папку ОТНОСИТЕЛЬНО переданного item
    result:=_tSrcTree_item_fsNodeFILE_(tSrcTree_item(SrcTree_fndPathREL(item,srcTree_fsFnk_ExtractFileDir(filePath))));
    // ищем сам файл внутри него
    if Assigned(result) then begin
        result:=_fndNodeFILE_(_tSrcTree_item_fsNodeFLDR_(tSrcTree_item(result)), srcTree_fsFnk_ExtractFileName(filePath));
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Поиск файла ОТНОСИТЕЛЬНО директории
function SrcTree_fndFileREL(const item:tSrcTree_fsFLDR; const filePath:string):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}Assert(Assigned(item),'item is NULL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_pathIsRelative(filePath),'not REL PATH');{$endIf}
    result:=SrcTree_fndFileREL(_tSrcTree_item_fsNodeFLDR_(item), filePath);
end;

// Поиск файла ОТНОСИТЕЛЬНО директории проэкта
function SrcTree_fndFileREL(const item:tSrcTree_BASE; const filePath:string):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}Assert(Assigned(item),'item is NULL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_pathIsRelative(filePath),'not REL PATH');{$endIf}
    result:=SrcTree_fndFileREL(_tSrcTree_item_fsNodeFLDR_(item), filePath);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Поиск файла ОТНОСИТЕЛЬНО "БАЗОВОЙ" директории проэкта
function SrcTree_fndFileREL(const item:tSrcTree_ROOT; const filePath:string):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}Assert(Assigned(item),'item is NULL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_pathIsRelative(filePath),'not REL PATH');{$endIf}
    // ищем целевую директорию, ОТНОСИТЕЛЬНО базового пути,
    // поиск проводим ОТНОСИТЕЛЬНО её
    result:=_tSrcTree_item_fsNodeFILE_(tSrcTree_item(SrcTree_fndPathREL(item,srcTree_fsFnk_ExtractFileDir(filePath))));
    // ищем сам файл внутри него
    if Assigned(result) then begin
        result:=_fndNodeFILE_(_tSrcTree_item_fsNodeFLDR_(tSrcTree_item(result)), srcTree_fsFnk_ExtractFileName(filePath));
    end;
end;

end.

