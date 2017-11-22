unit in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD;

{$mode objfpc}{$H+}

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


interface

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
        sysutils,
     {$endIf}

  in0k_lazIdeSRC_srcTree_CORE_fromIDEProcs_FNK,
  //
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_ADD,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_REL;

//function  srcTree_builder_add_SrchPATH(const ROOT:tSrcTree_ROOT; const Path:string; const KIND:eSrcTree_SrchPath; const crtFnc:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;  overload;
//function  srcTree_builder_add_SrchPATH(const ROOT:tSrcTree_ROOT; const Path:string; const KIND:eSrcTree_SrchPath; const crtFnc:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;  overload;
//function  srcTree_builder_add_SrchPATH(const ROOT:tSrcTree_ROOT; const Path:string; const KIND:eSrcTree_SrchPath):_tSrcTree_item_fsNodeFLDR_;                                             overload;
                              //FileItem
//procedure srcTree_builder_add_SearchPATH_DirLIST(const ROOT:tSrcTree_ROOT; const DirLIST:string; const KIND:eSrcTree_SrchPath; const crtFnc:mSrcTree_crt_FsFLDR_callBACK);

implementation

// добавить ПУТь поиска
// @prm ROOT     куда именно добавляем
// @prm Path  название директории (путь в файловой системе)
// @prm KIND тип "пути поиска"
function srcTree_builder_add_SrchPATH(const ROOT:tSrcTree_ROOT; const Path:string; const KIND:eSrcTree_SrchPath; const crtFnc:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin {todo: мож проверки добавить}
    result:=SrcTree_getFsFldrREL(ROOT,Path,crtFnc);
    {$ifDef _debug_}DEBUG('srcTree_builder_add_SearchPATH_DirNAME',Assigned2OK(result)+' KIND="'+SrcTree_SrchPathKIND_2_Text(KIND)+'"'+' Path="'+Path+'"');{$endIf}
    if Assigned(result) then begin
        //--- добавим найденному ТИП пути
        SrcTree_fsFolder__addSearchPATH(tSrcTree_fsFLDR(result),KIND);
    end;
end;

// добавить ПУТь поиска
// @prm ROOT     куда именно добавляем
// @prm Path  название директории (путь в файловой системе)
// @prm KIND тип "пути поиска"
function srcTree_builder_add_SrchPATH(const ROOT:tSrcTree_ROOT; const Path:string; const KIND:eSrcTree_SrchPath; const crtFnc:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin {todo: мож проверки добавить}
    result:=SrcTree_getFsFldrREL(ROOT,Path,crtFnc);
    {$ifDef _debug_}DEBUG('srcTree_builder_add_SearchPATH_DirNAME',Assigned2OK(result)+' KIND="'+SrcTree_SrchPathKIND_2_Text(KIND)+'"'+' Path="'+Path+'"');{$endIf}
    if Assigned(result) then begin
        //--- добавим найденному ТИП пути
        SrcTree_fsFolder__addSearchPATH(tSrcTree_fsFLDR(result),KIND);
    end;
end;

// добавить СПИСОК ПУТЕЙ поиска
// @prm ROOT     куда именно добавляем
// @prm DirLIST  список директорий с разделителем ";"
// @prm KIND тип "пути поиска"
procedure srcTree_builder_add_SearchPATH_DirLIST(const ROOT:tSrcTree_ROOT; const DirLIST:string; const KIND:eSrcTree_SrchPath; const crtFnc:mSrcTree_crt_FsFLDR_callBACK);
var StartPos:Integer;
    singlDir:string;
begin
    {$ifDef _debug_}DEBUG('srcTree_builder_add_SearchPATH_DirLIST','KIND="'+SrcTree_SrchPathKIND_2_Text(KIND)+'"'+' DirLIST="'+DirLIST+'"');{$endIf}
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(DirLIST,StartPos);
    while singlDir<>'' do begin
        srcTree_builder_add_SrchPATH(ROOT,singlDir,KIND,crtFnc);
        //-->
        singlDir:=GetNextDirectoryInSearchPath(DirLIST,StartPos);
    end;
end;

//------------------------------------------------------------------------------

function _crtFLDR_(const FolderPATH:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(FolderPATH);
end;

function srcTree_builder_add_SrchPATH(const ROOT:tSrcTree_ROOT; const Path:string; const KIND:eSrcTree_SrchPath):_tSrcTree_item_fsNodeFLDR_;
begin
    result:=srcTree_builder_add_SrchPATH(ROOT, Path,KIND,@_crtFLDR_);
end;

end.

