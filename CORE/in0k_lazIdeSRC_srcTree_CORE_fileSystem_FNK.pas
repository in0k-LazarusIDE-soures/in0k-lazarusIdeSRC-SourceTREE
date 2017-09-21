unit in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  FileUtil,LazFileUtils;


function srcTree_fsFnk_ChompPathDelim(const Path: string):string; inline;
function srcTree_fsFnk_CreateRelativePath(const Filename,BaseDirectory:string; UsePointDirectory:boolean=false; AlwaysRequireSharedBaseFolder:Boolean=True):string; inline;
function srcTree_fsFnk_ExtractFileName(const FileName:string):string; inline;
function srcTree_fsFnk_ExtractFileNameOnly(const AFilename:string):string; inline;

function srcTree_fsFnk_ExtractFileDir (const FileName:string):string; inline;
function srcTree_fsFnk_ExtractFileExt (const FileName:string):string; inline;
function srcTree_fsFnk_FilenameIsAbsolute (const TheFilename:string):boolean; inline;
function srcTree_fsFnk_FilenameIsRelative (const TheFilename:string):boolean; inline;
function srcTree_fsFnk_FilenameIsPascalUnit(const TheFilename:string):boolean; inline;

function srcTree_fsFnk_FileIsText(const AFilename: string): boolean; inline;

function srcTree_fsFnk_FileIsInPath(const Filename,Path:string):boolean; inline;

function srcTree_fsFnk_TrimFilename(const AFilename:string):string; inline;

function srcTree_fsFnk_ChangeFileExt(const aFileName,aExtension:string): string;

function srcTree_fsFnk_CompareFilenames(const Filename1, Filename2: string): integer; inline;
function srcTree_fsFnk_CompareFileExt  (const Filename, Ext: string; const CaseSensitive: boolean): integer; overload; inline;
function srcTree_fsFnk_CompareFileExt  (const Filename, Ext: string): integer; overload; inline;


function srcTree_fsFnk_CleanAndExpandFilename(const Filename: string): string; inline;// empty string returns current directory


function srcTree_fsFnk_endsWithDirectorySeparator(const Path: string):boolean; inline;


function srcTree_fsFnk_startsWithDirectorySeparator(const Path:string):boolean; //inline;





implementation

function srcTree_fsFnk_ChompPathDelim(const Path:string):string;
begin
    result:=ChompPathDelim(Path);
end;

function srcTree_fsFnk_CreateRelativePath(const Filename,BaseDirectory:string; UsePointDirectory:boolean=false; AlwaysRequireSharedBaseFolder:Boolean=True):string; inline;
begin
    result:=CreateRelativePath(Filename,BaseDirectory, UsePointDirectory,AlwaysRequireSharedBaseFolder);
end;

function srcTree_fsFnk_ExtractFileName(const FileName:string):string;
begin
    result:=ExtractFileName(FileName);
end;

function srcTree_fsFnk_ExtractFileNameOnly(const AFilename:string):string;
begin
    result:=ExtractFileNameOnly(AFilename);
end;


function srcTree_fsFnk_ExtractFileDir (const FileName:string):string;
begin
    result:=ExtractFileDir(FileName);
end;

function srcTree_fsFnk_ExtractFileExt (const FileName:string):string;
begin
    result:=ExtractFileExt(FileName);
end;


function srcTree_fsFnk_FilenameIsAbsolute(const TheFilename:string):boolean;
begin
    result:=FilenameIsAbsolute(TheFilename);
end;

function srcTree_fsFnk_FilenameIsRelative(const TheFilename:string):boolean;
begin
    result:=not FilenameIsAbsolute(TheFilename);
    {$ifOpt D+}{$IFDEF Windows}
        Assert(NOT srcTree_fsFnk_startsWithDirectorySeparator(TheFilename),'`TheFilename` starts With `DirectorySeparator`.');
    {$endIf}{$endIf}
end;

function srcTree_fsFnk_FilenameIsPascalUnit(const TheFilename:string):boolean;
begin
    result:=FilenameIsPascalUnit(TheFilename);
end;

function srcTree_fsFnk_FileIsText(const AFilename: string): boolean;
begin
    result:=FileIsText(AFilename);
end;

function srcTree_fsFnk_FileIsInPath(const Filename,Path:string):boolean;
begin
    result:=FileIsInPath(Filename,Path);
end;

function srcTree_fsFnk_CompareFilenames(const Filename1,Filename2:string):integer;
begin
    result:=CompareFilenames(Filename1,Filename2);
end;

function srcTree_fsFnk_CompareFileExt(const Filename, Ext: string; const CaseSensitive: boolean): integer;
begin
    result:=CompareFileExt(Filename, Ext, CaseSensitive);
end;

function srcTree_fsFnk_CompareFileExt(const Filename, Ext: string): integer;
begin
    result:=CompareFileExt(Filename, Ext);
end;

function srcTree_fsFnk_TrimFilename(const AFilename:string):string;
begin
    result:=TrimFilename(AFilename);
end;

function srcTree_fsFnk_ChangeFileExt(const aFileName,aExtension:string):string;
begin
    result:=ChangeFileExt(aFileName,aExtension);
end;

function srcTree_fsFnk_CleanAndExpandFilename(const Filename: string): string;
begin
    result:=CleanAndExpandFilename(Filename);
end;


// и далее по коду
//------------------------------------------------------------------------------
// работа со строками реализована как в Lazarus`овских файлах
// как это соотносится с веяниями на тип `string` и всякими `UTF` я НЕ знаю.
// возможно придеся переделать!

// проверить: ПУТЬ заканчивается символом разделителя `DirectorySeparator`.
function srcTree_fsFnk_endsWithDirectorySeparator(const Path: string):boolean;
begin
    result:=(Length(Path)>1) and (Path[Length(Path)] in AllowDirectorySeparators);
end;

// проверить: ПУТЬ начинается символом разделителя `DirectorySeparator`.
function srcTree_fsFnk_startsWithDirectorySeparator(const Path:string):boolean;
begin // подсмотрено в LazFileUtils.ExpandFileNameUtf8
    result:=(Length(Path)>1) and (Path[1] in AllowDirectorySeparators);
end;

end.

