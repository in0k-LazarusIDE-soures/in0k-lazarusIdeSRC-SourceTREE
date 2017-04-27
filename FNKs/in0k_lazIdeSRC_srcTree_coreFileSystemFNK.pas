unit in0k_lazIdeSRC_srcTree_coreFileSystemFNK;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  LazFileUtils;


function srcTree_fsFnk_ChompPathDelim(const Path: string):string; inline;
function srcTree_fsFnk_CreateRelativePath(const Filename,BaseDirectory:string; UsePointDirectory:boolean=false; AlwaysRequireSharedBaseFolder:Boolean=True):string; inline;
function srcTree_fsFnk_ExtractFileName(const FileName:string):string; inline;
function srcTree_fsFnk_FilenameIsAbsolute (const TheFilename:string):boolean; inline;
function srcTree_fsFnk_FileIsInPath(const Filename,Path:string):boolean; inline;

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

function srcTree_fsFnk_FilenameIsAbsolute (const TheFilename:string):boolean;
begin
    result:=FilenameIsAbsolute(TheFilename);
end;

function srcTree_fsFnk_FileIsInPath(const Filename,Path:string):boolean;
begin
    result:=FileIsInPath(Filename,Path);
end;

end.

