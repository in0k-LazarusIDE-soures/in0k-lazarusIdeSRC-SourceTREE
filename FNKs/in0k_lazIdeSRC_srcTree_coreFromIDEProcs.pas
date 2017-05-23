unit in0k_lazIdeSRC_srcTree_coreFromIDEProcs;

{$mode objfpc}{$H+}

interface

uses
  LazFileCache, //<????
  FileUtil,     //<????

  //Classes,
  //SysUtils,
  //LazFileUtils,
  in0k_lazIdeSRC_srcTree_coreFileSystemFNK;


const cSearchPaths_delimeter=';';



//!!! начинать с NextStartPos=1
function GetNextDirectoryInSearchPath(const SearchPath: string; var NextStartPos: integer): string;

// проверить, есть ли связанный с файлом файл ресурсов ... очень странный способ
function FilenameIsPascalSource8HasResources(const Filename:string): boolean;
// получить имя
function FilenameIsPascalSource_getRsrc_Name(const Filename:string): string;


implementation

function GetNextDirectoryInSearchPath(const SearchPath: string;
                                      var NextStartPos: integer): string;
var
  PathLen: Integer;
  CurStartPos: Integer;
begin
  PathLen:=length(SearchPath);
  if PathLen>0 then begin
    repeat
      while (NextStartPos<=PathLen)
      and (SearchPath[NextStartPos] in [cSearchPaths_delimeter,#0..#32]) do
        inc(NextStartPos);
      CurStartPos:=NextStartPos;
      while (NextStartPos<=PathLen) and (SearchPath[NextStartPos]<>cSearchPaths_delimeter) do
        inc(NextStartPos);
      Result:=srcTree_fsFnk_TrimFilename(copy(SearchPath,CurStartPos,NextStartPos-CurStartPos));
      if Result<>'' then exit;
    until (NextStartPos>PathLen);
  end else begin
    NextStartPos:=1;
  end;
  Result:='';
end;


function FilenameIsFormText(const Filename: string): boolean;
var Ext: string;
begin
  Ext:=lowercase(srcTree_fsFnk_ExtractFileExt(Filename));
  Result:=((Ext='.lfm') or (Ext='.dfm') or (Ext='.xfm'))
          and (srcTree_fsFnk_ExtractFileNameOnly(Filename)<>'');
end;


{function FilenameIsPascalSource(const Filename: string): boolean;
var Ext: string;
  p: Integer;
  AnUnitName: String;
begin
  AnUnitName:=ExtractFileNameOnly(Filename);
  if (AnUnitName='') or (not IsValidIdent(AnUnitName)) then
    exit(false);
  Ext:=lowercase(ExtractFileExt(Filename));
  for p:=Low(PascalFileExt) to High(PascalFileExt) do
    if Ext=PascalFileExt[p] then
      exit(true);
  Result:=(Ext='.lpr') or (Ext='.dpr') or (Ext='.dpk');
end; }

function FilenameIsPascalSource_getRsrc_Name(const Filename:string):string;
begin
    result:='';
    if FilenameIsPascalUnit(Filename)
    then begin
        result:=srcTree_fsFnk_ChangeFileExt(Filename,'.lfm')
    end;
end;

function FilenameIsPascalSource8HasResources(const Filename:string):boolean;
begin
    result:=FilenameIsPascalUnit(Filename) AND
            FileExistsCached(FilenameIsPascalSource_getRsrc_Name(Filename));
end;

end.

