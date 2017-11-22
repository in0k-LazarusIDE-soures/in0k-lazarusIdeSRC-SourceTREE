//function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:xSrcTree_crt_FsFILE_callBACK; const crtFLDR:xSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
    {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(path)
    then result:=SrcTree_getFsFileABS(item, path,{fileKind,} crtFILE,crtFLDR)
    else result:=SrcTree_getFsFileREL(item, path,{fileKind,} crtFILE,crtFLDR);
end;

