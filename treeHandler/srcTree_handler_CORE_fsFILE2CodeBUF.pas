unit srcTree_handler_CORE_fsFile2CodeBUF;

{$mode objfpc}{$H+}

interface

uses
  LazIDEIntf,
  //---
  CodeCache,
  CodeToolManager,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  //---
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  srcTree_handler_CORE;

type

 tSrcTree_itmHandler_fsFile2CodeBUF=class(tSrcTree_itmHandler)
  protected
   _codeBUF_:TCodeBuffer;
  public
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

implementation

function tSrcTree_itmHandler_fsFile2CodeBUF.Processing:boolean;
var tmp:string;
begin
    {$ifOpt D+}Assert(Assigned(prcssdDATA), self.ClassName+'.Processing : prcssdDATA=NIL');{$endIf}
    {$ifOpt D+}Assert(tObject(prcssdDATA) is tSrcTree_fsFILE, self.ClassName+'.Processing : tObject(prcssdDATA) is NOT tSrcTree_fsFILE');{$endIf}
    //---
    // make sure the filename is trimmed and contains a full path
    tmp:=srcTree_fsFnk_CleanAndExpandFilename(tSrcTree_fsFILE(prcssdDATA).src_PATH);
    // save changes in source editor to codetools
    LazarusIDE.SaveSourceEditorChangesToCodeCache(nil);
    // load the file
   _codeBUF_:=CodeToolBoss.LoadFile(tmp,true,false);
    //
    result:=true;
end;

end.

