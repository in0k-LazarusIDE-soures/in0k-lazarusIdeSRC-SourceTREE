unit in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  FileUtil,LazFileUtils;


function srcTree_fsFnk_pathIsAbsolute(const path:string):boolean; inline;
function srcTree_fsFnk_pathIsRelative(const path:string):boolean; inline;


function srcTree_fsFnk_AppendPathDelim(const Path: string):string; inline;
function srcTree_fsFnk_ChompPathDelim (const Path: string):string; inline;
function srcTree_fsFnk_ConcatPaths    (const PathA, PathB: string):string; inline;

function srcTree_fsFnk_CreateRelativePath(const Filename,BaseDirectory:string; UsePointDirectory:boolean=false; AlwaysRequireSharedBaseFolder:Boolean=True):string; inline;
function srcTree_fsFnk_ExtractFirstDIR(const FileName:string):string; inline;
function srcTree_fsFnk_ExtractFileDrive(const FileName:string):string; inline;
function srcTree_fsFnk_ExtractFileName(const FileName:string):string; inline;
function srcTree_fsFnk_ExtractFileNameOnly(const AFilename:string):string; inline;





//function srcTree_fsFnk_ExtractFilePath(const FileName:string):string; inline;
function srcTree_fsFnk_ExtractFileDir (const FileName:string):string; inline;
function srcTree_fsFnk_ExtractFileExt (const FileName:string):string; inline;








function srcTree_fsFnk_FilenameIsPascalUnit(const TheFilename:string):boolean; inline;

function srcTree_fsFnk_FileIsText(const AFilename: string): boolean; inline;

function srcTree_fsFnk_FileIsInPath(const Filename,Path:string):boolean; inline;

function srcTree_fsFnk_TrimFilename(const AFilename:string):string; inline;

function srcTree_fsFnk_ChangeFileExt(const aFileName,aExtension:string): string;

function srcTree_fsFnk_CompareFilenames(const Filename1, Filename2: string): integer; inline;
function srcTree_fsFnk_NamesEqual      (const name1,name2:string):boolean; inline;
function srcTree_fsFnk_CompareFileExt  (const Filename, Ext: string; const CaseSensitive: boolean): integer; overload; inline;
function srcTree_fsFnk_CompareFileExt  (const Filename, Ext: string): integer; overload; inline;


function srcTree_fsFnk_namesIdentical(const name1,name2:string):boolean;


function srcTree_fsFnk_CleanAndExpandFilename(const Filename: string): string; inline;// empty string returns current directory


function srcTree_fsFnk_endsWithDirectorySeparator(const Path: string):boolean; inline;


function srcTree_fsFnk_startsWithDirectorySeparator(const Path:string):boolean; //inline;





implementation

function srcTree_fsFnk_pathIsAbsolute(const path:string):boolean;
begin  //ForceDirectoriesUTF8();
    {$ifOpt D+}
        Assert(NOT srcTree_fsFnk_endsWithDirectorySeparator(path),'`path` ends With `DirectorySeparator`.');
    {$endIf}
    result:=FilenameIsAbsolute(path);
end;

function srcTree_fsFnk_pathIsRelative(const path:string):boolean;
begin
    {$ifOpt D+}
        Assert(NOT srcTree_fsFnk_endsWithDirectorySeparator(path),'`path` ends With `DirectorySeparator`.');
    {$endIf}
    result:=not FilenameIsAbsolute(path);
    {$ifOpt D+}{$IFDEF Windows}
        if result then Assert(NOT srcTree_fsFnk_startsWithDirectorySeparator(path),'`path` starts WithOUT `DirectorySeparator`.');
    {$endIf}{$endIf}
end;

//------------------------------------------------------------------------------




function srcTree_fsFnk_AppendPathDelim(const Path: string):string; inline;
begin
    result:=AppendPathDelim(Path);
end;

function srcTree_fsFnk_ChompPathDelim(const Path:string):string;
begin
    result:=ChompPathDelim(Path);
end;

function srcTree_fsFnk_ConcatPaths(const PathA, PathB: string):string;
begin
    result:='';
    if (PathA<>'')and(PathB<>'') then result:=AppendPathDelim(PathA);
    result:=result+PathB;
end;


function srcTree_fsFnk_CreateRelativePath(const Filename,BaseDirectory:string; UsePointDirectory:boolean=false; AlwaysRequireSharedBaseFolder:Boolean=True):string; inline;
begin
    result:=CreateRelativePath(Filename,BaseDirectory, UsePointDirectory,AlwaysRequireSharedBaseFolder);
end;


{function srcTree_fsFnk_ExtractFilePath(const FileName:string):string;
begin
    result:=ExtractFilePath(FileName);
end; }

function srcTree_fsFnk_ExtractFileName(const FileName:string):string;
begin
    result:=ExtractFileName(FileName);
end;

function srcTree_fsFnk_ExtractFileNameOnly(const AFilename:string):string;
begin
    result:=ExtractFileNameOnly(AFilename);
end;

function srcTree_fsFnk_ExtractFirstDIR(const FileName:string):string;

    function _test_(const aDRV:string; Const Dir: string; out resDIR:string): Boolean;
    var ADir : String;
        APath: String;
    begin
        result:=FALSE;
        resDIR:='';
        //
        ADir:=ExcludeTrailingPathDelimiter(Dir);
        if (ADir='') then Exit;
        //
        APath:=ExtractFilePath(ADir);
        if (APath=aDRV) then result:=TRUE
        else begin
            if _test_(aDRV,APath,resDIR) then begin
                resDIR:=ADir;
            end;
        end;
    end;

var ADrv:string;
begin
    result:='';
    //
    ADrv := ExtractFileDrive(FileName);
    if (ADrv='') then EXIT;
    //
   _test_(aDRV, FileName,result);
end;

function srcTree_fsFnk_ExtractFileDrive(const FileName:string):string;
begin
    result:=ExtractFileDrive(FileName);
end;


function srcTree_fsFnk_ExtractFileDir (const FileName:string):string;
begin
    result:=ExtractFileDir(FileName);
end;

function srcTree_fsFnk_ExtractFileExt (const FileName:string):string;
begin
    result:=ExtractFileExt(FileName);
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

function srcTree_fsFnk_NamesEqual(const name1,name2:string):boolean;
begin
    result:=0=srcTree_fsFnk_CompareFilenames(name1,name2);
end;

function srcTree_fsFnk_namesIdentical(const name1,name2:string):boolean;
begin
    result:=0=srcTree_fsFnk_CompareFilenames(name1,name2);
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

