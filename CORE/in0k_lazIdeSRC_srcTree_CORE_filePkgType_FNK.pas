unit in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  CodeCache,
  CodeToolManager,
  sysutils, typinfo,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK;

function srcTree_ftPkg_PkgFileTypeToString  (pft:TPkgFileType):string;

function srcTree_ftPkg_FileNameToPkgFileType(AFilename:string):TPkgFileType;


implementation


function srcTree_ftPkg_PkgFileTypeToString(pft:TPkgFileType):string;
begin
    result:=GetEnumName(TypeInfo(TPkgFileType), integer(pft));
end;

// `lazarus\paskager\PackageDefs.pas`

function srcTree_ftPkg_FileNameToPkgFileType(AFilename: string): TPkgFileType;
var
  Code: TCodeBuffer;
  SrcType: String;
  HasName: Boolean;
begin
  HasName:=srcTree_fsFnk_ExtractFileNameOnly(AFilename)<>'';
  if HasName then begin
    if srcTree_fsFnk_CompareFileExt(AFilename,'.lfm',true)=0 then
      exit(pftLFM)
    else if srcTree_fsFnk_CompareFileExt(AFilename,'.lrs',true)=0 then
      exit(pftLRS)
    else if srcTree_fsFnk_CompareFileExt(AFilename,'.inc',true)=0 then
      exit(pftInclude)
    else if srcTree_fsFnk_CompareFileExt(AFilename,'.xml',true)=0 then
      exit(pftIssues)
    else if srcTree_fsFnk_FilenameIsPascalUnit(AFilename) then begin
      Result:=pftUnit;
      AFilename:=srcTree_fsFnk_CleanAndExpandFilename(AFilename);
      Code:=CodeToolBoss.LoadFile(aFilename,true,false);
      if Code<>nil then begin
        SrcType:=CodeToolBoss.GetSourceType(Code,false);
        if CompareText(SrcType,'unit')<>0 then
          Result:=pftInclude;
      end;
      exit;
    end;
  end;
  if srcTree_fsFnk_FileIsText(AFilename) then
    Result:=pftText
  else
    Result:=pftBinary;
end;

end.

